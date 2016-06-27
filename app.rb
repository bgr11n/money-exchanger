$:.unshift '.'

require 'boot'

module API
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
