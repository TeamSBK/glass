require 'glass/config'
require 'glass/define_orm'
require 'glass/engine'
require "glass/version"

module Glass
  def self.configure(&block)
    block.call(Glass::Config)
  end
end
