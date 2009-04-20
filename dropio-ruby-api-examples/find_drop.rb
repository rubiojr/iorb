#!/usr/bin/env ruby
require 'rubygems'
require 'dropio'
include Dropio

#
# Find a public drop and get some attributes
#

#
# get your API key @ http://api.drop.io
#
Dropio.api_key = 'your_api_key_here'

drop_name = 'rubyclient'
begin

  # throws Dropio::MissionResourceError if not found
  drop = Drop.find(drop_name)
  # Drop public URL
  puts "Public URL:      http://drop.io/#{drop.name}"

  # Drop size limit
  puts "Max Bytes:       #{drop.max_bytes}"

rescue Dropio::MissingResourceError
  puts 'Drop does not exist.'
rescue Dropio::AuthorizationError # no permissions to read the drop
  puts 'Not authorized.'
end

