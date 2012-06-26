require 'rubygems'
require 'nokogiri'
require 'open-uri'

url2 = "http://stgeorge.biz/premium-business-listings/accountants-and-cpas"
url = "http://www.walmart.com/search/search-ng.do?search_query=batman&ic=16_0&Find=Find&search_constraint=0"
doc = Nokogiri::HTML(open(url))
# Title
# puts doc.at_css("title").text

doc.css(".item").each do |node|
  title = node.at_css(".prodLink").text 
  price = node.at_css(".camelPrice").text[/\$[0-9\.]+/]
  puts "#{title} - #{price}"
end
