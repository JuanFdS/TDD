class Cart
  attr_writer :catalog
  def initialize
    @contents = Hash.new { 0 }
    @catalog = Catalog.new
  end

  def empty?
    @contents.empty?
  end

  def validate_added_quantity(qty)
    raise ArgumentError, 'Quantity cannot be negative' unless qty > 0
  end

  def validate_item(isbn)
    raise ArgumentError, 'Book is not from this Editorial' unless @catalog.valid_isbn? isbn
  end

  def add(isbn, qty)
    validate_item(isbn)
    validate_added_quantity(qty)
    @contents[isbn] += qty
  end
  def has?(isbn)
    @contents.include? isbn
  end
  def list
    @contents
  end

  def checkout
    raise RuntimeError, "Can't checkout an empty cart" if empty?
  end

  def total_amount
    @contents.map{ |(isbn, qty)| qty * @catalog.unit_price_of(isbn) }.sum
  end
end

class Catalog
  def initialize(isbns = {})
    @isbns = isbns
  end

  def add_isbn(isbn, unit_price)
    @isbns.merge!({isbn => unit_price})
  end

  def unit_price_of(isbn)
    @isbns.fetch(isbn)
  end

  def valid_isbn?(isbn)
    @isbns.keys.include? isbn
  end
end

class Array
  def sum(&block)
    map(&block).reduce(0, :+)
  end
end