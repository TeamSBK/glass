require 'glass/config'
require 'glass/abstract_model'
require 'glass/engine'
require "glass/version"

module Glass
  def self.configure(&block)
    block.call(Glass::Config)
  end
end
