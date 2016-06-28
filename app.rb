$:.unshift '.'

require 'boot'

module API
  def self.exchanger
    @exchanger ||= Exchanger::ATM.new(1 => 10, 2 => 10, 5 => 10, 10 => 10, 25 => 10, 50 => 10)
  end

  class Base < Grape::API
    format :json

    mount API::ExchangerController
  end
end

APIServer = Rack::Builder.new do
  map '/api' do
    use Rack::Cors do
      allow do
        origins '*'
        resource '*'
      end
    end

    run API::Base
  end
end
