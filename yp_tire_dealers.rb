require 'rubygems'
require 'mechanize'

HOME_URL = "http://www.yellowpages.com/saint-george-ut/trends/1"

mech = Mechanize.new 										
mech.user_agent_alias = "Linux Firefox"
mech.get(HOME_URL)  															
mech.page.search('.categories-list a').each do |link|       
  mech.click(link)
 
  mech.page.search('.listing_content').each do |business|	
  #subpage.download(business.link, 'business.txt')
  bus = business.css('.url').text.strip
  address = business.css('.street-address').text.strip
  
  city = business.css('.locality').text.strip
  state = business.css('.region').text.strip
  zip = business.css('.postal-code').text.strip


  puts "#{bus} #{address}, #{city}, #{state}, #{zip} \n \n"

  end
   a = gets
end