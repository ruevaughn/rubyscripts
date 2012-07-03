require 'rubygems'
require 'mechanize'
require 'spreadsheet'
  
def next_button(yellowpages, worksheet, row_num)
  yellowpages.page.search('.next a').each do |next_button|
    yellowpages.click(next_button)
    yellowpages.page.search('.listing_content').each do |business|
      get_business_info(business, worksheet, row_num)
    end
    next_button(yellowpages, worksheet, row_num)
  end
end

  def get_business_info(business, worksheet, row_num)
    @row_num += 1
    bus = business.at_css('.url').text.strip
    address = business.css('.street-address').text.strip
    city = business.css('.locality').text.strip
    state = business.css('.region').text.strip 
    zip = business.css('.postal-code').text.strip
    website = business.at_css('.website-feature')
    website = website.at_css('a')['href'] if website

    # gets data to excel file
    row = worksheet.row(@row_num)
    row.push bus, address, city, state, zip, website
  end

# Establish connection to site 
HOME_URL = "http://www.yellowpages.com/saint-george-ut/trends/1"
yellowpages = Mechanize.new                     
yellowpages.user_agent_alias = "Linux Firefox"
yellowpages.get(HOME_URL)

# Initialize excel document
excel_doc = Spreadsheet::Workbook.new
a = 0

yellowpages.page.search('.page-navigation a').each do |pagination_link|
  yellowpages.page.search('.categories-list a').each do |link|       
    # if a > 206
    #  puts "over #{a}"
    #  a = gets
    # end 
    # a += 1
    # puts a
    worksheet = excel_doc.create_worksheet
    worksheet.name = link.text
    worksheet.row(0).concat %w{Company Address City State Zip Website}
    @row_num = 0
  
    yellowpages.click(link)
  
    excel_doc.write 'businesses.xls'
  
    yellowpages.page.search('.listing_content').each do |business|  
      get_business_info(business, worksheet, @row_num)
    end

    next_button(yellowpages, worksheet, @row_num)
  end
  puts "Next Page"
  yellowpages.click(pagination_link)
end