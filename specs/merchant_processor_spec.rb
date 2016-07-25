require 'rspec'
require_relative 'helpers'
require_relative '../src/merchant_processor'

describe MerchantProcessorStub do
  include_context 'Cart'
  include_context 'Cashier'

  context 'When it is down' do
    let(:behavior) { proc { raise RuntimeError, 'Merchant processor is down' } }
    it 'returns an error and sale is not registered' do
      expect{cashier.checkout(cart_with_a_book, valid_card)}.to raise_error RuntimeError, 'Merchant processor is down'
      expect(sales_book.empty?).to be true
    end
  end

  context 'When the credit card has funds' do
    let(:behavior) {
      proc { | amount, card |
        @amount = amount
        @card = card
      }
    }
    it 'the merchant processor register the payment and sale is registered in sales book' do
      cashier.checkout(cart_with_a_book, valid_card)
      expect(sales_book.size).to be 1
      expect(merchant_processor.amount).to be a_total_amount
      expect(merchant_processor.card).to be valid_card
    end
  end

  context 'When the credit card has not funds' do
    let(:behavior) { proc { raise RuntimeError, 'The credit card does not have sufficient funds' } }
    it 'returns an error and sale is not registered' do
      expect{cashier.checkout(cart_with_a_book, valid_card)}.to raise_error RuntimeError, 'The credit card does not have sufficient funds'
      expect(sales_book.empty?).to be true
    end
  end
end