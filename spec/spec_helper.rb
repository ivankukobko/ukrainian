$:.unshift File.expand_path("../lib", File.dirname(__FILE__))
require 'ukrainian'
include Ukrainian
RSpec.configure do |config|
  config.color_enabled = true
end
