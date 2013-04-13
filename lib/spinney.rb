require 'spinney/info'
require 'pathname'

module Spinney
  def self.resource(name)
    Pathname.new(__FILE__).dirname.join('spinney/resources', name)
  end
end
