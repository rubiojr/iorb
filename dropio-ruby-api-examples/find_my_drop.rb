#!/usr/bin/env ruby
require 'rubygems'
require 'dropio'
include Dropio

#
# Finds you have created (got admin token)
#
# And displays some properties
#

#
# get your API key @ http://api.drop.io
#
Dropio.api_key = 'your_api_key_here'
admin_token = '0000000000'
drop_name = 'mydropname'

begin

  drop = Drop.find(drop_name, admin_token)

rescue Dropio::MissingResourceError
  puts 'Drop does not exist.'
rescue Dropio::AuthorizationError # no permissions to read the drop
  puts 'Not authorized.'
end

#
# Drop details
#
# Drop public URL
puts "Public URL:      http://drop.io/#{drop.name}"
# Drop size limit
puts "Max Bytes:       #{drop.max_bytes}"
# Drop inbox (mail items to this drop)
puts "Email:           #{drop.email}"
puts "Admin Token:     #{drop.admin_token}"
puts "Hidden Uploads:  #{drop.hidden_upload_url}"
# Get the admin URL
puts "Admin URL:       #{drop.generate_url}"
