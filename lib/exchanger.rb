module Exchanger
  class ATM
    NOMINALS = [1, 2, 5, 10, 25, 50]

    def initialize(coin_data)
      validate_init_data(coin_data)
      @coins = coin_data
    end

  private

    def validate_init_data(data)
      raise Exchanger::CoinDataFormatError, "coin data must be a hash" if !data.is_a?(Hash)
      raise Exchanger::CoinDataFormatError, "provide valid coin nominals: #{NOMINALS}" if (data.keys.map(&:to_i) - NOMINALS).size > 0
      raise Exchanger::CoinDataFormatError, "coins amount must be a positive number" if (data.values.map { |v| v.to_i > 0 } - [true]).size > 0
    end
  end
end
