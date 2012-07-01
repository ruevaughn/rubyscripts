require 'rubygems'
require 'mechanize'
require 'spreadsheet'

# Establish connection to site 
HOME_URL = "http://www.yellowpages.com/saint-george-ut/trends/1"
yellowpages = Mechanize.new                     
yellowpages.user_agent_alias = "Linux Firefox"
yellowpages.get(HOME_URL)

# Initialize excel document
excel_doc = Spreadsheet::Workbook.new
a = 0
# This iterator goes through each link on the trends/1 page and clicks it
yellowpages.page.search('.categories-list a').each do |link|       
  # Prepare new worksheet within excel spreadsheet for current business category
  worksheet = excel_doc.create_worksheet
  worksheet.name = link.text
  worksheet.row(0).concat %w{Company Address City State Zip}

  yellowpages.click(link)
  
  puts '*'
  row_num = 0
  
  # if a >= 50
  #  puts "over 50"
  # a = gets
  # end 
  # a += 1
  
  yellowpages.page.search('.listing_content').each do |business|	
    
    row_num += 1
    bus = business.css('.url').text.strip
    address = business.css('.street-address').text.strip
    city = business.css('.locality').text.strip
    state = business.css('.region').text.strip 
    zip = business.css('.postal-code').text.strip
    website = business.css('.website-feature').at_css('track-visit-website no-tracks')
    website.text
    a = gets
    # gets data to excel file
    row = worksheet.row(row_num)
    row.push bus
    row.push address
    row.push city
    row.push state
    row.push zip
    excel_doc.write 'businesses.xls'
  end


end