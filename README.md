rubyscripts
===========

1. Setup and Tools
  - gem install nokogiri
  - gem install mechanize
  - CSS selector found here http://www.selectorgadget.com/

2. Introducution

This project is to teach me more about web crawling in general. The goal is to get an XML document with all of the business in St. George, including address, city, zip, phone number, email, website, facebook, twitter, etc.

3. Files

nokogiri_test.rb
This is a quick smoke test to ensure you have installed nokogiri properly. gem install nokogiri is all that was needed for me. This script opens the url that searched for 'batman' on the walmart.com website, and displays the title and price for each one.

stgeorgebiz_accountants.rb
This was my first attempt to use nokogiri. The CSS selectors for site are hard to navigate. I got it to where I could essentially pull the required info and then write it out to a txt file. Feels very fragile and 'patched' to me. I know there is a better way to do this. Also, every time I run this script the result order varies. Not sure why yet.

yp_tire_dealers.rb
This is my first attempt to use nokogiri AND mechanize. I know that I will most likely end up using only mechanize since it usese nokogiri under the hood, but for now I am mixing them. Instead of pulling from stgeorge.biz I have decided to try to use yellowpages as a source for my data gathering, the css seletors seem much more reliable.

