class Cart
  attr_writer :editorial
  def initialize
    @contents = Hash.new { 0 }
    @editorial = Editorial.new
  end
  def empty?
    @contents.empty?
  end
  def add(isbn, qty)
    raise NotInEditorialISBNError unless @editorial.valid_isbn? isbn
    @contents[isbn] += qty
  end
  def has?(isbn)
    @contents[isbn] != 0
  end
  def list
    @contents
  end
end

class Editorial
  def initialize(isbns = [])
    @isbns = isbns
  end
  def add_isbn(isbn)
    @isbns << isbn
  end
  def valid_isbn?(isbn)
    @isbns.include? isbn
  end
end

class NotInEditorialISBNError < ArgumentError

end