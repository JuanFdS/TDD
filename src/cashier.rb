class Cashier
  def initialize(date, sales_book, merchant_processor)
    @current_date = date
    @sales_book = sales_book
    @merchant_processor = merchant_processor
  end

  def validate_cart(cart)
    raise ArgumentError, "Can't checkout an empty cart" if cart.empty?
  end

  def validate_card(card)
    raise ArgumentError, "Can't checkout with expired card" if card.expired_on? date_today
  end

  def checkout(cart, card)
    validate_cart cart
    validate_card card
    current_transaction = Transaction.new(cart, card, date_today)
    current_transaction.process(@merchant_processor)
    @sales_book.push current_transaction
  end
  def date_today
    @current_date
  end
end

class Card
  def initialize(expiration_date)
    @expiration_date = expiration_date
  end

  def expired_on?(date)
    @expiration_date <= MonthYear.from_date(date)
  end
end

class Transaction
  def initialize(cart, card, date)
    @cart = cart
    @card = card
    @date = date
  end
  def total_amount
    @cart.total_amount
  end

  def process(merchant_procesor)
    merchant_procesor.charge(total_amount, @card)
  end
end

=begin
class SalesBook
  include Enumerable

  def each(&block)
    @pending_sales.each(&block)
  end

  def initialize
    @pending_sales = []
  end

  def register(transaction)
    @pending_sales << transaction
  end

  def process(merchant_processor)
    @pending_sales.each do | transaction |
      transaction.process(merchant_processor)
    end
  end

  def size
    count
  end
end
=end
