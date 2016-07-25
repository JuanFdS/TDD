require 'rspec'
require_relative '../src/cart'
require_relative '../src/cashier'
require_relative '../src/month_year'

shared_context 'Cart' do
  let(:cart) do cart = Cart.new
    cart.catalog= an_editorial
    cart
  end
  let(:cart_with_a_book) do cart = Cart.new
    cart.catalog= an_editorial
    cart.add(a_valid_ISBN, a_qty)
    cart
  end
  let(:a_valid_ISBN) {'1234'}
  let(:an_invalid_ISBN) {'9794'}
  let(:a_valid_price) { 7 }
  let(:an_editorial) { Catalog.new({a_valid_ISBN => a_valid_price}) }
  let(:a_qty) { 1 }
  let(:a_total_amount) { a_qty * a_valid_price }
end

shared_context 'Cashier' do
  let(:behavior) { proc {} }
  let(:merchant_processor) { MerchantProcessorStub.new(behavior) }
  let(:cashier) { Cashier.new(today, sales_book, merchant_processor) }
  let(:valid_card) { Card.new(MonthYear.new(2018, 7)) }
  let(:expired_card) { Card.new(MonthYear.new(2016, 6)) }
  let(:today) { Time.new(2016, 07, 25) }
  let(:sales_book) { [] }
end