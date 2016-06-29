module Exchanger
  class BaseError < StandardError ; end
  class CoinDataFormatError < BaseError ; end
  class InputFormatError < BaseError ; end
  class OutOfCoinsError < BaseError ; end
  class OutNominalsError < BaseError ; end
end
