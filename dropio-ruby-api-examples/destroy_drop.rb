#!/usr/bin/env ruby
require 'rubygems'
require 'dropio'
include Dropio

#
# Find a drop you have created (got admin token)
# and destroy it
#

#
# get your API key @ http://api.drop.io
#
Dropio.api_key = 'your_api_key_here'
admin_token = '0000000000'
drop_name = 'mydropname'

begin

  drop = Drop.find(drop_name, admin_token)
  drop.destroy # that's all!

rescue Dropio::MissingResourceError
  puts 'Drop does not exist.'
rescue Dropio::AuthorizationError # no permissions to read the drop
  puts 'Not authorized.'
end
