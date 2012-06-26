require 'rubygems'
require 'nokogiri'
require 'mechanize'
require 'open-uri'

# functions
def get_business()
end
url = "http://www.yellowpages.com/saint-george-ut/tire-dealers"
doc = Nokogiri::HTML(open(url))

#first loop 
doc.css(".listing_content").each do |business|
  name = business.css(".url").text
  puts name
end
#once loop is finished, click the next button and do it again
doc.css(".next").each do |button|
  link = button.css("a")
  link.end
   
click