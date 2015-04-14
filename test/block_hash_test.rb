require 'rubygems'
require 'test/unit'

require '../lib/block_hash'

class BlockHashTest < Test::Unit::TestCase
  
  def test_evaluate
    assert_equal({}, BlockHash.evaluate)
  end
  
  def test_evaluate_inheritance
    assert_equal({1 => 2}, BlockHash.evaluate({1 => 2}))
  end
  
  def test_evaluate_with_block
    config = BlockHash.evaluate do |o|
      o.name    "maurycy"
      o.email   "maurycy@g.pl"
    end
    
    assert config.is_a?(Hash)
    assert_equal "maurycy", config[:name]
    assert_equal "maurycy@g.pl", config[:email]
  end
  
  def test_evaluate_with_proc
    block = proc {|o|
      o.name    "maurycy"
      o.email   "maurycy@g.pl"
    }
    
    config = BlockHash.evaluate(nil, &block)
    
    assert config.is_a?(Hash)
    assert_equal "maurycy", config[:name]
    assert_equal "maurycy@g.pl", config[:email]
  end
  
  def test_evaluate_within_method
    
    def sappy(&block)
      BlockHash.evaluate(&block)
    end
    
    config = sappy do |o|
      o.name    "maurycy"
      o.email   "maurycy@g.pl"
    end
    
    assert config.is_a?(Hash)
    assert_equal "maurycy", config[:name]
    assert_equal "maurycy@g.pl", config[:email]
  end
  
  def test_evaluate_empty
    config = BlockHash.evaluate do |o|
    end
    
    assert config.is_a?(Hash)
    assert config.empty?
  end
  
  def test_evaluate_with_empty_param
    config = BlockHash.evaluate do |o|
      o.test
    end
    
    assert config.is_a?(Hash)
    assert_equal nil, config[:test]
  end
  
  def test_evaluate_setter_filtered
    config = BlockHash.evaluate do |o|
      o.test = 'a'
    end
    
    assert config.is_a?(Hash)
    assert_equal 'a', config[:test]
  end
  
  def test_evaluate_overwritten
    config = BlockHash.evaluate do |o|
      o.test = 'a'
      o.test   'b'
    end
    
    assert config.is_a?(Hash)
    assert_equal 'b', config[:test]
  end
  
  def test_evaluate_inheritance
    config = {}
    config[:test] = 'a'
    
    config = BlockHash.evaluate(config) do |o|
      o.test 'c'
    end
    
    assert config.is_a?(Hash)
    assert_equal 'c', config[:test]
  end
end
