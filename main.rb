require 'nokogiri'
require 'open-uri'

if __FILE__ == $0
  url = 'https://www.hospitalsafetygrade.org/all-hospitals'
  pattern = /^http\:\/\/www\.hospitalsafetyscore\.org\/h\//
  doc = Nokogiri::HTML(URI.open(url))
  result = []
  doc.css('.content')[0].search('a').each do |link|
    result << link.content if link['href'] =~ pattern and !result.include? link.content
  end
  puts "Got #{result.length} items"
  File.open('result.csv', 'w') { |file| file.puts result}
  puts "Saved to file"
end