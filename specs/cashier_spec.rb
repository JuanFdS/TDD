require 'rspec'
require_relative '../src/cashier'
require_relative '../src/month_year'
require_relative 'helpers'

describe Cashier do
  include_context 'Cart'
  include_context 'Cashier'
  context 'when checking out' do
    it 'the cart cannot be empty' do
      expect{cashier.checkout(cart, valid_card)}.to raise_error(ArgumentError, "Can't checkout an empty cart")
    end

    describe 'credit card validations' do
      it 'cannot be expired' do

        expect{cashier.checkout(cart_with_a_book, expired_card)}.to raise_error(ArgumentError, "Can't checkout with expired card")
      end
    end

    context 'successfully' do

      it 'saves a transaction in the salesbook' do
        cart.add(a_valid_ISBN, a_qty)
        cashier.checkout(cart, valid_card)

        expect(sales_book.size).to be 1
        expect(sales_book.first.total_amount).to be (a_valid_price * a_qty)
      end
    end
  end
end