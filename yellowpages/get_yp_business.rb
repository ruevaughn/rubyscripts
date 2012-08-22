#gem 'mechanize', '=1.0.0'
# gem install --version '=1.0.0' mechanize
require 'rubygems'
require 'mechanize'
require 'csv'

class MyApp
  def initialize 
    home_url = "http://www.yellowpages.com/saint-george-ut/trends/1"
    $yellowpages = Mechanize.new   
    $yellowpages.user_agent_alias = "Linux Firefox"
    $yellowpages.get(home_url)
    $a = 0
  end

  def run
    a = $a
    $yellowpages.page.search('.page-navigation a').each do |pagination_link|
      $yellowpages.page.search('.categories-list a').each do |link| 
        
        # if a == 5
        #  puts "over #{a}"
        #  a = gets
        # end 
        # a += 1
        #puts a      

        $yellowpages.click(link)
        $yellowpages.page.search('.listing_content').each do |business|  
          get_business_info(business, @row_num)
        end
        next_button($yellowpages, @row_num)
      end
  
      puts "Next Page"
      $yellowpages.click(pagination_link)
    end

  end

  def next_button(yellowpages, row_num)
    $yellowpages.page.search('.next a').each do |next_button|
      $yellowpages.click(next_button)
      $yellowpages.page.search('.listing_content').each do |business|
        get_business_info(business, row_num)
      end
      next_button($yellowpages, row_num)
    end
  end

  def get_business_info(business, row_num)

    bus = business.at_css('.url').text.strip
    address = business.css('.street-address').text.strip
    city = business.css('.locality').text.strip
    state = business.css('.region').text.strip 
    zip = business.css('.postal-code').text.strip
    website = business.at_css('.website-feature')
    website = website.at_css('a')['href'] if website
    CSV.open("businesses.csv", "w") do |csv|
      csv << [bus, address, city, state, zip, website]
      puts "wrote"
    end

  end
end
MyApp.new.run