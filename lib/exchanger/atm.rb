module Exchanger
  class ATM
    NOMINALS = [1, 2, 5, 10, 25, 50]

    def initialize(coins_data)
      validate_init_data(coins_data)
      @coins = format_coins(coins_data)
    end

    def exchange(input)
      validate_input(input)

      result = Hash.new(0)
      need = input.to_i
      result_amount = 0
      coins.each do |nominal, amount|
        size = [need / nominal, amount].min
        result[nominal] = size
        coins[nominal] -= size
        result_amount += size * nominal
        coins.delete(nominal) if coins[nominal] < 1
        need = need - size * nominal
        break if need == 0
      end
      raise OutNominalsError, "Cannot exchangr Required amount, choose another one" if result_amount < input.to_i
      result
    end

  private
    attr_accessor :coins

    def validate_init_data(data)
      raise CoinDataFormatError, "Coin data must be a hash" unless data.is_a?(Hash)
      raise CoinDataFormatError, "Provide valid { key => value } pair" unless (data.keys + data.values).map{ |v| v.respond_to?(:to_i) }.all?
      raise CoinDataFormatError, "Provide valid coin nominals: #{NOMINALS}" if (data.keys.map(&:to_i) - NOMINALS).size > 0
      raise CoinDataFormatError, "Coins amount must be a positive number" unless data.values.map { |v| v.to_i > 0 }.all?
    end

    def validate_input(value)
      raise InputFormatError, "Provide valid required amount" unless value.respond_to?(:to_i)
      raise InputFormatError, "Required amount must be a positive number" unless value.to_i > 0
      raise OutOfCoinsError, "Out of money, max amount: #{balance}" if value.to_i > balance
    end

    def balance
      @balance ||= @coins.map { |nominal, amount| nominal * amount }.inject(:+)
    end

    def format_coins(coins_data)
      Hash[coins_data.to_a.map { |a| a.map(&:to_i) }.sort { |a, b| b <=> a }]
    end
  end
end
