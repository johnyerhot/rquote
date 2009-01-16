# rQuote - Simple, realtime stock market quoting Ruby on Rails plugin
# Homepage: rquote.yerhot.org
# Repository: git://github.com/johnyerhot/rquote.git
# Author: John Yerhot (john@yerhot.org)
# Sample Usage:
# quote = Rquote.new
# quote.find("aapl", "msft") 
# => [{:change=>"-4.02", :price=>"169.72", :volume=>"16105013", :symbol=>"aapl"}, {:change=>"-0.42", :price=>"27.52", :volume=>"27024456", :symbol=>"msft"}]

require 'cgi'
require 'net/http'

class Rquote

@@service_uri = "http://download.finance.yahoo.com/d/quotes.csv"
  
  def find(*args)
    output = Array.new
    i = 0
    String.new(send_request(*args)).each do |line|
      a = line.chomp.split(",")
      output << { :symbol => args[i].to_s, 
                  :price => a[0],
                  :change => a[1], 
                  :volume => a[2]
                }
      i += 1
    end
    return output
  end
  
  def send_request(*args)
    completed_path = @@service_uri + construct_args(*args)
    uri = URI.parse(completed_path)
    response = Net::HTTP.start(uri.host, uri.port) do |http|
      http.get completed_path
    end
    return response.body
  end
  
  def construct_args(*args)
    path = "?f=l1c1v&s=" + args.map{|x| CGI.escape(x)}.join(",")
  end

end
