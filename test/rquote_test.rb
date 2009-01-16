require 'test/unit'
require 'lib/rquote'

class RquoteTest < Test::Unit::TestCase
  # a pretty comment case is to pull
  # data from the common financial indices.
  # there was previously a bug which had problems
  # loading them beause the ticker was invalid 
  # url parameter and raise an exception
  def test_normal_indices
    dow_jones_ticker = "^DJI"
    quote = Rquote.new
    assert_nothing_raised do
      quote.find(dow_jones_ticker).class
    end
  end
end
