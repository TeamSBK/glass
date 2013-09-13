require 'glass'

Glass.configure do |config|

  # Set the application name here
  config.app_name = "TestApp"
  config.models = ['User']

  # Set the format that would be used for this application. Default is json
  config.format = :json

  # Set the mountable path for Glass.js to recognize the URL
  # Default is '/api'
  config.mounted_at = '/api'

end
