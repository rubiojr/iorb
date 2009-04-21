#!/usr/bin/env ruby
require 'rubygems'
require 'dropio'
include Dropio

#
# List assets from a drop
#

#
# get your API key @ http://api.drop.io
#
Dropio.api_key = 'your_api_key_here'
admin_token = '0000000000'
drop_name = 'a_drop_name'

begin

  #
  # admin_token is optional.
  # if the drop is public you don't need it
  #
  # drop = Drop.find(drop_name)
  drop = Drop.find(drop_name, admin_token)
  drop.assets.each do |a|
    puts "Asset found: #{a.name}"
  end

rescue Dropio::MissingResourceError
  puts 'Drop does not exist.'
rescue Dropio::AuthorizationError # no permissions to read the drop
  puts 'Not authorized.'
end
