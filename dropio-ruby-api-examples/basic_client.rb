#!/usr/bin/env ruby
require 'rubygems'
require 'dropio'
include Dropio

#
# drop.io ruby client example.
#
# Create a new drop and upload a file
#
# Usage: dropio_rubyclient <file>
#
raise ArgumentError.new('Usage: dropio <file>') if not File.exist?(ARGV[0] || '')

#
# get your API key @ http://api.drop.io
#
Dropio.api_key = 'your_api_key_here'

#
# Create the drop
#
drop = Drop.create(
  { :expiration_length => '1_DAY_FROM_NOW',
    :description => 'foo stuff',
    :guests_can_add => false,
    :guests_can_comment => false,
  }
)

#
# Drop details
#
drop.email
drop.max_bytes
drop.name
drop.admin_token
drop.hidden_upload_url
# Get the admin URL
drop.generate_url

puts "Drop URL:            http://drop.io/#{drop.name}"
puts "Admin URL:           #{drop.generate_url}"

#
# Add a file to the drop
#
asset = drop.add_file(ARGV[0])
#
# File details
# 
asset.filesize
asset.type
asset.status
asset.hidden_url
asset.name
asset.description

puts "Filename:            #{asset.name}"
puts "File URL:            http://drop.io/#{drop.name}/asset/#{asset.name}"
