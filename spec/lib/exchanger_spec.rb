require 'spec_helper'

describe Exchanger::ATM do
  it { expect(described_class::NOMINALS).to eq([1, 2, 5, 10, 25, 50]) }
  it 'properly assign coins data' do
    expect(described_class.new("1" => 10, 2 => "10").send(:coins)).to eq({2 => 10, 1 => 10})
  end

  describe 'validations' do
    it 'validates incoming data [bad value]' do
      [
        [1, -1], # not a hash
        { {1 => 1} => "qa", 2 => 30, 5 => 10 }, # not a hash
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

    def atm(data)
      described_class.new(data)
    end

    it 'return valid coin data' do
      [
        { 25 => 10, 50 => 10 } ,         { 50 => 4 },                   200,
        { 25 => 4, 50 => 2 },            { 50 => 1 },                   50,
        { 10 => 10, 25 => 4 },           { 25 => 3, 10 => 1 },          85,
        { 5 => 2, 2 => 5, 1 => 10 },     { 5 => 2, 2 => 5, 1 => 4 },    24
      ].each_slice(3) do |atm_coins, result, input|
        expect(atm(atm_coins).exchange(input)).to eq(result)
      end
    end

    it 'lost coins after exchange' do
      my_atm = atm({ 50 => 5, 25 => 2, 10 => 30 })
      my_atm.exchange(200)
      expect(my_atm.send(:coins)).to eq({ 50 => 1, 25 => 2, 10 => 30 })
    end

    describe 'raises error when' do
      it 'wrong input format' do
        my_atm = atm({ 50 => 5, 25 => 2, 10 => 30 })
        ["asd", -1, { 1 => 10 }, [1, 10]].each do |input|
          expect{ my_atm.exchange(input) }.to raise_error(Exchanger::InputFormatError)
        end
      end

      it 'out of money' do
        expect{ atm({ 10 => 1, 25 => 2 }).exchange(200) }.to raise_error(Exchanger::OutOfCoinsError)
      end

      it 'out of nominals' do
        expect{ atm({ 50 => 1, 25 => 2 }).exchange(20) }.to raise_error(Exchanger::OutNominalsError)
      end
    end
  end
end
