class BlockHash
  
  def self.evaluate(hash=nil, &block)
    silly = self.new(hash)
    block.call(silly) if block_given?
    silly.hash
  end
  
  attr_accessor :hash
  
  def initialize(h)
    self.hash = h || {}
  end
  
  def method_missing(sym, *args, &block)
    key = sym.to_s.gsub(/\=$/, '').to_sym
    self.hash[key] = args.pop
  end
end
