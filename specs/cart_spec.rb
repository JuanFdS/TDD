require 'rspec'
require_relative '../src/cart'
require_relative 'helpers'

describe Cart do
  include_context 'Cart'

  context 'when it is created' do
    it 'can be empty' do
      expect(cart.empty?).to be true
    end
  end

  context 'when a book is added' do

      context 'successfully' do
        it 'is not empty' do
          cart.add a_valid_ISBN, a_qty

          expect(cart.empty?).to be false
        end

        it 'should have the added book' do
          cart.add a_valid_ISBN, a_qty

          expect(cart.has?(a_valid_ISBN)).to be true
        end
      end

      context 'when the book ISBN is not from the editorial' do
        it 'raises an error' do
          expect{cart.add(an_invalid_ISBN, 1)}.to raise_exception(ArgumentError, 'Book is not from this Editorial')
        end
      end
      it 'with a negative quantity it should raise an Error' do
          expect{cart.add(a_valid_ISBN, -1)}.to raise_error(ArgumentError, 'Quantity cannot be negative')
      end
  end

  context 'when it is listed' do
    it 'returns its contents' do
      cart.catalog= an_editorial
      cart.add a_valid_ISBN, 5

      expect(cart.list).to eq ({a_valid_ISBN => 5})
    end
  end

  context '#total_amount' do
    it 'is 0 if its empty' do
      expect(cart.total_amount).to be 0
    end

    it 'equal to the sum of the prices of its items' do
      cart.add a_valid_ISBN, 6
      expect(cart.total_amount).to be 42
    end
  end

  describe 'validity of cart' do
    context 'when less than 30 minutes passed since last operation' do
      it 'is valid' do
        skip
        expect(cart.valid?).to be true
      end
    end
    context 'when 30 minutes passed since last operation' do
      it 'is invalid' do
        skip
        cart.expire
        expect(cart.valid?).to be false
      end
    end
  end

end