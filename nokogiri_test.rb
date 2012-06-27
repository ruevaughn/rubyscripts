require 'rubygems'
require 'nokogiri'
require 'open-uri'

# Test Walmart
url = "http://www.walmart.com/search/search-ng.do?search_query=batman&ic=16_0&Find=Find&search_constraint=0"
doc = Nokogiri::HTML(open(url))

 
doc.css(".item").each do |node|
  title = node.at_css(".prodLink").text 
  price = node.at_css(".camelPrice").text[/\$[0-9\.]+/]
  puts "#{title} - #{price}"
end

# Test yellowpages

url = "http://www.yellowpages.com/saint-george-ut/tire-dealers"
doc = Nokogiri::HTML(open(url))

doc.css(".listing_content").each do |business|
  name = business.css(".url").text
  puts name
end

doc.css(".next").each do |button|
  link = button.css("a")
  link.end