require 'glass/config'
require "glass/version"

module Glass
  def self.configure(&block)
    block.call(Glass::Config)
  end
end


