require 'rails'
require 'glass'

module Glass
  class Engine < Rails::Engine
    isolate_namespace Glass
  end
end
