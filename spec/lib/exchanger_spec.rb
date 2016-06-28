require 'spec_helper'

describe Exchanger::ATM do
  it { expect(described_class::NOMINALS).to eq([1, 2, 5, 10, 25, 50]) }
  it 'prperly assign coins data' do
    expect(described_class.new("1" => 10, 2 => "10").send(:coins)).to eq({1 => 10, 2 => 10})
  end

  describe 'validations' do
    it 'validates incoming data [bad value]' do
      [
        [1, -1], # not a hash
        { 1 => "qa", 2 => 30, 5 => 10 }, # wrong amount of coin (0 amount of coin)
        { 1 => -1, 2 => 30, 5 => 10 }, # negative amount of coin
        { 1 => 0, 2 => 30, 5 => 10 }, # 0 amount of coin
        { 3 => 10, 1 => 20, 5 => 10 } # unknown coin nominal
      ].each do |bad_value|
        expect{ described_class.new(bad_value) }.to raise_error(Exchanger::CoinDataFormatError)
      end
    end

    it 'validates incoming data [good value]' do
      [
        { 1 => "10", 2 => 10, 5 => 10 },
        { "1" => 10, 2 => 10, 5 => 10 },
        { 1 => 10, 2 => 10, 5 => 10 }
      ].each do |good_value|
        expect{ described_class.new(good_value) }.to_not raise_error
      end
    end
  end

  describe '#exchange' do
  end
end
