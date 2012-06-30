require 'rubygems'
require 'mechanize'
require 'spreadsheet'

book = Spreadsheet::Workbook.new
sheet1 = book.create_worksheet
puts book.class
puts sheet1.class
a = gets

 sheet1.row(0).concat %w{Name Country Acknowlegement}
  sheet1[1,0] = 'Japan'
  row = sheet1.row(1)
  row.push 'Creator of Ruby'
  row.unshift 'Yukihiro Matsumoto'
  sheet1.row(2).replace [ 'Daniel J. Berger', 'U.S.A.',
                          'Author of original code for Spreadsheet::Excel' ]
  sheet1.row(3).push 'Charles Lowe', 'Author of the ruby-ole Library'
  sheet1.row(3).insert 1, 'Unknown'
  sheet1.update_row 4, 'Hannes Wyss', 'Switzerland', 'Author'

   book.write 'businesses.xls'

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
  # a = gets
end