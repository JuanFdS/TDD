class MerchantProcessorStub
  attr_accessor :amount, :card
  def initialize(behavior)
    @behavior = behavior
  end

  def charge(amount, card)
    self.instance_exec(amount, card, &@behavior)
  end
end


=begin
class FallenMerchantProcessor < MerchantProcessor
  def charge(amount, card)
    raise RuntimeError, 'Merchant is down'
  end
end

class SuccessMerchantProcessor < MerchantProcessor
  attr_accessor :amount, :card
  def charge(amount, card)
    @amount = amount
    @card = card
  end
end
=end
