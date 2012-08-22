require 'rubygems'  # apt-get install rubygems
require 'mechanize' # gem install mechanize
require 'nokogiri'  # gem install nokogiri
require 'csv'       # gem install csv

class MyApp
  def initialize 
    # Open local file with Nokogiri.
    @doc = Nokogiri::HTML(open('stgeorge-categories.html'))
    
    # Initialize Mechanize Agent
    @dexknows = Mechanize.new   
    @dexknows.user_agent_alias = "Linux Firefox"
  end

  def run
    # For each 'a' (business) link in local file, send it to Mechanize to do a page search on it.
    @doc.css('a').each do |a|
      link = a['href']
      @dexknows.get(link)
      @dexknows.page.search('.listing').each do |business|
        get_business_info(business)
      end
    end
  end

  # # # # 
  # Functions
  # # # #

  # I think you know what this function is doing
  def get_business_info(business)
    bus = business.at_css('.details h2 a').text.strip
    address = business.css('h3.address').text.strip
    phone = business.css('.phone').text.strip
    website_node = business.at_css('.tool_web a')
    website = website_node['href'] if website_node
    
    # Don't need these, they are in address
    # city = 'St. George'
    # state = 'UT' 
    # zip = '84770'

    CSV.open("businesses.csv", "a") do |csv|
      csv << [bus, address, phone, website]
    end
    puts "wrote #{bus}"
  end
end
MyApp.new.run