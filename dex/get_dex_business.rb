# gem 'mechanize', '=1.0.0'
# gem install --version '=1.0.0' mechanize
require 'rubygems'
require 'mechanize'
require 'csv'

class MyApp
  def initialize 
    home_url = "stgeorge-categories.html"
    $dexknows = Mechanize.new   
    $dexknows.user_agent_alias = "Linux Firefox"
    $dexknows.get(home_url)
    $a = 0
  end

  def run
    a = $a
      $dexknows.page.search('.siteMapFidget a').each do |link| 
        CSV.open("businesses.csv", "a") do |csv|
          csv << ["-", link]
        end
        
         #if a == 2
         # puts "over #{a}"
         # a = gets
         #end
         a += 1
         puts "#{a} - #{Time.now}"     

        $dexknows.click(link)
        $dexknows.page.search('.listing').each do |business|  
          get_business_info(business, @row_num)
        end
        next_button($dexknows, @row_num)
      end
  end

  def next_button(dexknows, row_num)
    $dexknows.page.search('a.prevnext').each do |next_button|
      $dexknows.click(next_button)
      $dexknows.page.search('.listing_content').each do |business|
        get_business_info(business, row_num)
      end
      next_button($dexknows, row_num)
    end
  end

  def get_business_info(business, row_num)

    bus = business.at_css('.details h2 a').text.strip
    address = business.css('h3.address').text.strip
    city = 'St. George'
    state = 'UT' 
    zip = '84770'
    phone = business.css('.phone').text.strip
    website = business.at_css('.tool_web a')
    website = website.at_css('a')['href'] if website

    CSV.open("businesses.csv", "a") do |csv|
      csv << [bus, address, city, state, zip, phone, website]
    end
  end
end
MyApp.new.run