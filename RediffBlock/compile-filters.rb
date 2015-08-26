#!/usr/bin/env ruby

require 'json'

blockerList = IO.readlines('./url-filter-block.txt').sort.map do |url|
  url.strip!
  next if url == ''
  next if url[0] == '#'

  {
    'trigger' => {
      'url-filter' => url
    },
    'action' => {
      'type' => 'block'
    }
  }
end.compact

puts JSON.pretty_generate(blockerList)