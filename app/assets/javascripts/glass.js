(function () {
  
  // Glass core module
  var Glass = Glass = function () {
    this.init();
  };

  // Configuration settings
  Glass.prototype.config = {};

  // CSRF token
  Glass.prototype.token = null;

  // Model names
  Glass.prototype.models = [];

  // Initialization
  Glass.prototype.init = function () {
    // Get the CSRF token that will be used for all requests
    this.token = this.getCsrfToken();

    this.getConfig((function (config) {
      if (config === undefined) throw new Error('Failed to get configuration data from the server.');

      this.config = config;

      var i = config.models.length;
      while (i--) {
        m = config.models[i];
        Glass.prototype[m] = new this.Model(m, config.routes[m.toLowerCase()]);
        Glass.prototype[m].token = this.token;
      }
    }).bind(this));
  };

  // Gets the CSRF token from the DOM
  Glass.prototype.getCsrfToken = function () {
    var token = document.querySelector('meta[name="csrf-token"]');
    if (!token) throw new Error('Could not find CSRF token.');
    else token = token.getAttribute('content');

    return token;
  };

  // Fires an XHR to get the config data from the server
  Glass.prototype.getConfig = function (callback) {
    // Get the config from the server
    this.get('/api', function (res, error) {
      if (!error) {
        var config = JSON.parse(res.response);
        callback(config, error);
      }
      else {
        callback(null, error);
      }
    }, false);
  };

  Glass.prototype.get = function (url, callback, async) {
    this.doXHR('GET', url, callback, async);
  };

  Glass.prototype.post = function (url, callback, async) {
    this.doXHR('POST', url, callback, async);
  }

  Glass.prototype.put = function (url, callback, async) {
    this.doXHR('PUT', url, callback, async);
  }

  Glass.prototype.delete = function (url, callback, async) {
    this.doXHR('DELETE', url, callback, async);
  }

  Glass.prototype.doXHR = function (type, url, callback, async) {
    if (arguments.length < 3) throw new Error('Glass#doXHR is missing ' + (3 - arguments.length) + ' parameters.');
    if (async === undefined) async = true;

    // Append our CSRF token
    url += ((url.indexOf('?') != -1) ? '&' : '?') + "csrf-token=" + this.token;

    var xhr = new XMLHttpRequest();
    xhr.open(type, url, async);
    xhr.setRequestHeader('Content-Type', 'application/json');

    xhr.onreadystatechange = (function () {
      if (xhr.readyState == 4) {
        if (xhr.status == 200 || xhr.status === 0) callback(xhr, null);
        else callback(null, 'Could not complete XMLHttpRequest to ' + url);
      }
    }).bind(this);

    xhr.send();
  }


  // Glass.Model module
  var Model = Glass.prototype.Model = function (name, routes) {
    this.init(name, routes);

    // Let's add the XHR functions to our model as well
    this.get = Glass.prototype.get;
    this.post = Glass.prototype.post;
    this.put = Glass.prototype.put;
    this.delete = Glass.prototype.delete;
    this.doXHR = Glass.prototype.doXHR;
  };

  Model.prototype.routes = null;

  Model.prototype.name = null;

  // Returns the total rows
  Model.prototype.count = function () {};

  // Model initialization
  Model.prototype.init = function (name, routes) {
    if (arguments.length < 2) throw new Error('Model#init() is missing ' + (2 - arguments.length) + ' parameters.');

    // Build the model's routes
    this.routes = routes;

    // Set this model's name
    this.name = name;
  };

  Model.prototype.findAll = function(callback) {
    this.find({}, callback); // Just call Model#find() with a blank options
  };

  Model.prototype.find = function(options, callback) {
    options || (options = {}); // providing no options means find all

    var queryParams = this.serialize(options),
        path = '/api' + this.routes['index'].path,
        url = (queryParams.length > 0) ? path + '?' + queryParams : path;

    this.get(url, function (res, error) {
      if (!error) {
        var result = JSON.parse(res.response);
        if (callback) callback(result, null);
      }
      else {
        if (callback) callback(null, error);
      }
    });
  };

  Model.prototype.findOne = function(options, callback) {
    // TODO: Find one record here; return first?
  }

  Model.prototype.findById = function(id, callback) {
    if (typeof id == 'function' || id === undefined) throw new Error("Model#findbyId() is missing 'id' parameter.");

    var route = this.routes['show'].path.replace(/:id/, id),
        url = '/api' + route;

    this.get(url, function (res, error) {
      if (!error) {
        var result = JSON.parse(res, error);
        if (callback) callback(res.body, null);
      }
      else {
        if (callback) callback(null, error);
      }
    });
  }

  Model.prototype.create = function(options, callback) {
    if (typeof options == 'function' || options === undefined) throw new Error("Model#create() is missing 'options' parameter.");

    var queryParams = this.serialize(options),
        path = '/api' + this.routes['create'].path,
        url = (queryParams.length > 0) ? path + '?' + queryParams : path;

    this.post(url, function (res, error) {
      if (!error) {
        var result = JSON.parse(res.response);
        if (callback) callback(result, null);
      }
      else {
        if (callback) callback(null, error);
      }
    });
  };

  Model.prototype.update = function(options, callback) {
    if (typeof options == 'function' || options === undefined) throw new Error("Model#update() is missing 'options' parameter.");

    if (options.hasOwnProperty('id')) {
      // Replace :id in our route with the value of id
      var route = this.routes['update'].path.replace(/:id/, options.id);
      delete options.id;
    }
    else {
      throw new Error("Model#update() is missing 'options.id' parameter.");
    }

    var queryParams = this.serialize(options),
        path = '/api' + route,
        url = (queryParams.length > 0) ? path + '?' + queryParams : path;

    this.put(url, function (res, error) {
      if (!error) {
        var result = JSON.parse(res.response);
        if (callback) callback(result, null);
      }
      else {
        if (callback) callback(null, error);
      }
    });
  };

  Model.prototype.delete = function(options, callback) {
    if (typeof options == 'function' || options === undefined) throw new Error("Model#delete() is missing 'options' parameter.");

    if (options.hasOwnProperty('id')) {
      // Replace :id in our route with the value of id
      var route = this.routes['destroy'].path.replace(/:id/, options.id);
      delete options.id;
    }
    else {
      throw new Error("Model#update() is missing 'options.id' parameter.");
    }

    var queryParams = this.serialize(options),
        path = '/api' + route,
        url = (queryParams.length > 0) ? path + '?' + queryParams : path;

    this.delete(url, function (res, error) {
      if (!error) {
        var result = JSON.parse(res.response);
        if (callback) callback(result, null);
      }
      else {
        if (callback) callback(null, error);
      }
    });
  };

  Model.prototype.serialize = function (obj) {
    var values = [],
        prefix = '';
    return this.recursiveSerialize(obj, values, prefix).join('&');
  };

  Model.prototype.recursiveSerialize = function(obj, values, prefix) {
    for (var key in obj) {
      if (typeof obj[key] == 'object') {
        if (prefix.length == 0) prefix += '[' + key + ']';
        else prefix += key;

        values = this.recursiveSerialize(obj[key], values, prefix);

        var prefixes = values.split('[');

        if (prefixes.length > 1) prefix = prefixes.slice(0, prefixes.length - 1).join('[');
        else prefix = prefixes[0];
      }
      else {
        value = encodeURIComponent(obj[key]);
        if (prefix.length > 0) var prefixedKey = prefix + '[' + key + ']';
        else prefixedKey = key;

        prefixedKey = encodeURIComponent(prefixedKey);

        if (value) values.push(prefixedKey + '=' + value);
      }
    }

    return values;
  };


  // Add Glass.js to window
  window.addEventListener('load', function () {
    var g = new Glass();
    window['glass'] = g;
  }, false);

}());
