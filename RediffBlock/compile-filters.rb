#!/usr/bin/env ruby

require 'json'
SCRIPT_DIR = File.dirname File.expand_path(__FILE__)

blocked_urls = IO.readlines(File.join(SCRIPT_DIR, 'url-filter-block.txt')).sort.map do |url|
  url.strip!
  next if url == ''
  next if url[0] == '#'

  {
    'trigger' => {
      'url-filter' => Regexp.escape(url) #.gsub(/\\/, "\\\\")
    },
    'action' => {
      'type' => 'block'
    }
  }
end.compact

custom_rules = [
  {
    'trigger' => {
      'url-filter': '.*',
      'resource-type' => ['font']
    },
    'action' => {
      'type' => 'block'
    }
  }
]

puts JSON.pretty_generate(
  custom_rules + blocked_urls
)