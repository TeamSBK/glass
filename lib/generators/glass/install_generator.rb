require 'rails/generators'

module Glass
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    desc "Glass Installation"

    def install
      routes = File.open(Rails.root.join('config/routes.rb')).try :read
      initializer = (File.open(Rails.root.join('config/initializers/glass.rb')) rescue nil).try :read

      gsub_file "config/routes.rb", /mount Glass::Engine => \'api'\, as: :\'rails_admin\'/, ''
      route("mount Glass::Engine => '/api', as: :glass"

      template "initializer.rb", 'config/initializers/glass.rb' unless initializer
    end
  end
end
