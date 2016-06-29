module API
  class ExchangerController < Grape::API
    prefix :exchanger

    helpers do
      # TODO: Handle other errors. Different case for different environments
      def rescue_from_exchange_error &block
        yield
      rescue Exchanger::BaseError => e
        { error: e.message }
      end
    end

    params do
      requires :amount, type: Integer, desc: 'Amount you want to exchange.'
    end
    get '/exchange' do
      rescue_from_exchange_error do
        API.exchanger.exchange(params[:amount])
      end
    end
  end
end
