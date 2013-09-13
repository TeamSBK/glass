require 'rails/generators'

module Glass
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    desc "Glass Uninstalltion"

    def uninstall
      remove_file 'config/initializers/glass.rb'
      remove_file 'vendor/assets/javascripts/glass.js'
      gsub_file "config/routes.rb", /mount Glass::Engine => \'api'\, as: :\'rails_admin\'/, ''
    end
  end
end
