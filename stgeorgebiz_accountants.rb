require 'rubygems'
require 'nokogiri'
require 'mechanize'
require 'open-uri'

url = "http://stgeorge.biz/premium-business-listings/accountants-and-cpas"
doc = Nokogiri::HTML(open(url))

file = File.open('test.txt', 'w') 

doc.css("#content .block div div").each do |business|
  name = business.css(".business_name").text
  category = business.css("p:nth-child(2)").text
  address = business.css("p:nth-child(3)").text
  city_state_zip = business.css("p:nth-child(4)").text  
  puts name if name != ""
  puts category if category != ""
  puts address if address != ""
  puts city_state_zip if city_state_zip != ""


  file.write(name) if name != ""
  file.puts '/n'
end
file.close

