rubyscripts
===========

1. Setup and Tools
  - gem install nokogiri
  - gem install mechanize
  - CSS selector found here http://www.selectorgadget.com/

2. Introducution

This project is to teach me more about web crawling in general. The goal is to get an XLS or CSV document with all of the business in St. George, including address, city, zip, phone number, email, website, facebook, twitter, etc.

3. Files

dex/get_dex_business.rb
This file is customized to dex/stgeorge-categoires.html. It pulls straight from that file so businesses are structured and no website scraping is required.

yellowpages/get_yp_business.rb
First attempt to collect businesses from Yellow Pages, wasn't categorising businesses properly so moved onto dex.

