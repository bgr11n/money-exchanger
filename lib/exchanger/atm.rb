module Exchanger
  class ATM
    NOMINALS = [1, 2, 5, 10, 25, 50]

    def initialize(coins_data)
      validate_init_data(coins_data)
      @coins = format_coins(coins_data)
    end

  private
    attr_accessor :coins

    def validate_init_data(data)
      raise CoinDataFormatError, "coin data must be a hash" unless data.is_a?(Hash)
      raise CoinDataFormatError, "provide valid { key => value } pair" unless (data.keys + data.values).map{ |v| v.respond_to?(:to_i) }.all?
      raise CoinDataFormatError, "provide valid coin nominals: #{NOMINALS}" if (data.keys.map(&:to_i) - NOMINALS).size > 0
      raise CoinDataFormatError, "coins amount must be a positive number" unless data.values.map { |v| v.to_i > 0 }.all?
    end

    def format_coins(coins_data)
      Hash[coins_data.to_a.map { |a| a.map(&:to_i) }.sort { |a, b| b <=> a }]
    end
  end
end
