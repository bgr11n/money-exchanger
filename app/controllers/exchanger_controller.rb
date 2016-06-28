module API
  class ExchangerController < Grape::API
    prefix :exchanger

    get '/' do
      API.exchanger
    end
  end
end
