require 'rubygems'  # apt-get install rubygems
require 'mechanize' # gem install mechanize
require 'nokogiri'  # gem install nokogiri
require 'csv'       # gem install csv

class MyApp
  def initialize 
    # Delete business.csv if it exists
    File.delete("businesses.csv") if File.exist?("businesses.csv")

    # Open local file with Nokogiri.
    @doc = Nokogiri::HTML(open('stgeorge-categories.html'))
    
    # Initialize Mechanize Agent
    @dexknows = Mechanize.new   
    @dexknows.user_agent_alias = "Linux Firefox"
  end

  def run
    # For each 'a' (business) link in local file, send it to Mechanize to do a page search on it.
    @doc.css('a').each do |a|

      CSV.open("businesses.csv", "a") do |csv|
        csv << [a.text]
      end
      link = a['href']
      @dexknows.get(link)
      @dexknows.page.search('.listing').each do |business|
        get_business_info(business)
      end
      puts "Wrote #{a.text}"
    end
  end

  # # # # 
  # Functions

  def get_business_info(business)
    bus = business.at_css('.details h2 a').text.strip
    address = business.css('h3.address').text.strip
    phone = business.css('.phone').text.strip
    website_node = business.at_css('.tool_web a')
    website = website_node['href'] if website_node

    CSV.open("businesses.csv", "a") do |csv|
      csv << [bus, address, phone, website]
    end
  end
end
MyApp.new.run