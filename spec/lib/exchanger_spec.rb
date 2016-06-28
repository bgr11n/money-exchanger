require 'spec_helper'

describe Exchanger::ATM do
  it { expect(described_class::NOMINALS).to eq([1, 2, 5, 10, 25, 50]) }

  describe 'validations' do
    it 'validates incoming data [bad value]' do
      [
        [1, -1], # not a hash
        { 1 => "qa", 2 => 30, 5 => 10 }, # wrong amount of coin
        { 1 => -1, 2 => 30, 5 => 10 }, # negative amount of coin
        { 3 => 10, 1 => 20, 5 => 10 } # unknown coin nominal
      ].each do |bad_value|
        expect{ described_class.new(bad_value) }.to raise_error(Exchanger::CoinDataFormatError)
      end
    end
  end

  describe '#exchange' do
  end
end
