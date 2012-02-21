# exercise_5.rb
require 'net/http'
require 'open-uri'
require 'nokogiri'
require 'hpricot'

TEST_EXPRESSION = /\bthe\b/i
PAGE_URL = "http://satishtalim.github.com/webruby/chapter3.html"

def count_matches(text_to_match)
  text_to_match.scan(TEST_EXPRESSION).size
end

def output_expression_matches(text, library)
  count = count_matches(text)
  puts "Lbrary #{library} gives #{count} matches."
end

def using_uri
  url = URI.parse(PAGE_URL)

  Net::HTTP.start(url.host, url.port) do |http|
    req = Net::HTTP::Get.new(url.path)
    text = http.request(req).body
    output_expression_matches(text, "URI")
  end
end

def using_open_uri
  f = open(PAGE_URL)
  output_expression_matches(f.readlines.join, "Open-URI")
end

def using_hpricot
  page = Hpricot(open(PAGE_URL))
  output_expression_matches(page.inner_text, "Hpricot")
end

def using_nokogiri
  doc = Nokogiri::HTML(open(PAGE_URL))
  output_expression_matches(doc.inner_text, "Nokogiri")
end


using_uri
using_open_uri
using_hpricot
using_nokogiri