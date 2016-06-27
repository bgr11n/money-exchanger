require 'grape'
require 'rack/cors'

Dir["#{File.dirname(__FILE__)}/lib/**/*.rb"].each {|f| load(f) }
Dir["#{File.dirname(__FILE__)}/app/controllers/**/*.rb"].each {|f| load(f) }
