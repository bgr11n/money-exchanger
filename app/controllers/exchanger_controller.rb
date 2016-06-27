module API
  class ExchangerController < Grape::API
    prefix :exchanger

    get '/' do
      { status: 'ok' }
    end
  end
end
