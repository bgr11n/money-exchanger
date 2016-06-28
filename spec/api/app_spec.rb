require 'spec_helper'

describe API do
  it { expect(API.exchanger).to be_a_kind_of(Exchanger::ATM) }
end
