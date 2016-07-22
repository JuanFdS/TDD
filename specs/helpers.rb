require 'rspec'
require_relative '../src/cart'

shared_context 'Cart' do
  let(:cart) do cart = Cart.new
  cart.catalog= an_editorial
  cart
  end
  let(:a_valid_ISBN) {'1234'}
  let(:an_invalid_ISBN) {'9794'}
  let(:a_valid_price) { 7 }
  let(:an_editorial) { Catalog.new({a_valid_ISBN => a_valid_price}) }
  let(:a_qty) { 1 }
end