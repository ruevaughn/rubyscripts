require 'rubygems'
require 'mechanize'

HOME_URL = "http://www.yellowpages.com/saint-george-ut/trends/1"

mech = Mechanize.new
mech.user_agent_alias = "Linux Firefox"
mech.get(HOME_URL)

#Fix this method
mech.page.search('.categories-list a').each do |link|
  puts link
end