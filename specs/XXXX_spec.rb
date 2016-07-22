require 'rspec'
require_relative '../src/XXXX'

describe Cart do
  let(:cart) {Cart.new}
  let(:a_valid_ISBN) {'1234'}
  let(:an_invalid_ISBN) {'9794'}
  let(:an_editorial) { Editorial.new([a_valid_ISBN]) }
  let(:a_qty) { 1 }

  context 'when it is created' do
    it 'can be empty' do
      expect(cart.empty?).to be true
    end
  end

  context 'when a book is added' do

      before :each do
        cart.editorial= an_editorial
      end

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
          expect{cart.add(an_invalid_ISBN, 1)}.to raise_exception (NotInEditorialISBNError)
        end
      end
  end

  context 'when it is listed' do
    it 'returns its contents' do
      cart.editorial= an_editorial
      cart.add a_valid_ISBN, 5

      expect(cart.list).to eq ({a_valid_ISBN => 5})
    end
  end

  describe 'validity of cart' do
    context 'when less than 30 minutes passed since last operation' do
      it 'is valid' do


        expect(cart.valid?).to be true
      end
    end
    context 'when 30 minutes passed since last operation' do
      it 'is invalid' do
        cart.expire

        expect(cart.valid?).to be false
      end
    end
  end


end