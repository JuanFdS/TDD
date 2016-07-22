class Cashier
  def checkout(cart, card)
    raise ArgumentError, "Can't checkout an empty cart" if cart.empty?
    raise ArgumentError, "Can't checkout an empty cart" if card.expired_on? date_today
  end
end

class Card
  def initialize(expiration_date)
    @expiration_date = expiration_date
  end

  def expired_on?(date)
    Time.new(date.year, date.month) < Time.new(@expiration_date)
  end
end