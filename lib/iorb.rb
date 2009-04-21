require 'highline/import'

module IORB
  VERSION = "0.2.20090421102937"
  module Util
    # Code stolen from:
    # http://evan.tiggerpalace.com/2008/04/26/pastie-from-the-mac-clipboard/
    #
    class MacClipboard
      class << self
        def read
          IO.popen('pbpaste') {|clipboard| clipboard.read}
        end
        def write(stuff)
          IO.popen('pbcopy', 'w+') {|clipboard| clipboard.write(stuff)}
        end
      end
    end
  end

end
module IORB

  class DropManager
    def self.each
      drops = YAML.load_file(IORB::Config.file)['mydrops']
      if not drops.nil?
        drops.each do |key, val|
          next if val['destroyed'] == true
          yield IORB::DropDetails.build_from(val)
        end
      end
    end
    def self.find(name)
      each do |details|
        return details if details['name'] == name
      end
      nil
    end
  end

  class Config

    def self.check
      if not File.exist?(self.file)
        $stderr.puts "\niorb config file missing, creating one."
        key = ask("Paste you drop.io api key: ") { |q| q.echo = '*' }
        File.open(self.file, 'w') do |f|
          f.puts({ 'api-key' => (key.strip.chomp || 'invalid') }.to_yaml)
        end
        $stderr.puts "\nConfig file #{self.file} created.\n\n"
        exit 1
      end
    end

    def self.file
      "#{ENV['HOME']}/.iorbrc"
    end

    def self.api_key
      YAML.load_file(self.file)['api-key']
    end
  end

  class DropDetails < Hash

    def self.build_from(drop)
      details = DropDetails.new
      if drop.is_a? Dropio::Drop
        details['name'] = drop.name
        details['email'] = drop.email
        details['admin-url'] = drop.generate_url
        details['admin-token'] = drop.admin_token
        details['public-url'] = "http://drop.io/#{drop.name}"
        details['hidden-uploads'] = drop.hidden_upload_url
        details['max-bytes'] = drop.max_bytes
      else
        details['name'] = drop['name']
        details['email'] = drop['email']
        details['admin-url'] = drop['admin-url']
        details['admin-token'] = drop['admin-token']
        details['public-url'] = "http://drop.io/#{drop['name']}"
        details['hidden-uploads'] = drop['hidden-uploads']
        details['max-bytes'] = drop['max-bytes']
      end
      details
    end

    def print
      puts "Name:                 #{self['name']}"
      puts "Drop Email:           #{self['email']}"
      puts "URL:                  http://drop.io/#{self['name']}"
      puts "Max Bytes:            #{self['max-bytes']}"
      puts "Admin Token:          #{self['admin-token']}"
      puts "Hidden Upload URL:    #{self['hidden-uploads']}"
      # Get the admin URL
      puts "Admin URL:            #{self['admin-url']}"
    end

    def save
      config = YAML.load_file(IORB::Config.file)
      config['mydrops'] = {} if config['mydrops'].nil?
      config['mydrops'][self['name']] = {}.merge(self)
      File.open(IORB::Config.file, 'w') do |f|
        f.puts config.to_yaml
      end
    end
  end

end
