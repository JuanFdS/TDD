require 'rspec'
require_relative '../src/cashier'
require_relative 'helpers'

describe Cashier do
  let(:cashier) { Cashier.new(Time.new(2016, 7, 22)) }
  let(:valid_card) { Card.new(MonthYear.new(2018, 7)) }
  let(:expired_card) { Card.new(MonthYear.new(2016, 6)) }
  include_context 'Cart'
  context 'when checking out' do
    it 'the cart cannot be empty' do
      expect{cashier.checkout(cart, valid_card)}.to raise_error(ArgumentError, "Can't checkout an empty cart")
    end

    describe 'credit card validations' do
      it 'cannot be expired' do
        expect{cashier.checkout(cart, expired_card)}.to raise_error(ArgumentError, "Can't checkout with expired card")
      end
    end

    context 'successfully' do

      it 'returns something with a price' do
        skip
        cart.add(a_valid_ISBN, a_qty)
        expect(Cashier.new.checkout(cart).price).to be 7
      end
    end
  end

end