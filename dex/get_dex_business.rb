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
      @page_num = 1
      get_listings
      
      puts "Wrote #{@page_num} page(s) - #{a.text}"
    end
  end

  # # # # 
  # Functions

  # Loop through each business, calling get_business_info to extract data on each one, and then calling get_next_link  
  def get_listings
    @dexknows.page.search('.listing').each do |business|
      get_business_info(business)
    end
    get_next_link

  end

  # Click the next link if one exists, then call get_listings again. It will break out of it when last-child has no href.
  def get_next_link
    @dexknows.page.search('li:last-child .prevnext').each do |np|
      next_link = np['href']
      @dexknows.get(next_link)
      @page_num += 1
      get_listings
    end
  end

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