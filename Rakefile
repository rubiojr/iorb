require 'rake'
$:.unshift(File.dirname(__FILE__) + "/lib")
require 'hoe'
require 'iorb'

Hoe.new('iorb', IORB::VERSION) do |p|
  p.name = "iorb"
  p.author = "Sergio Rubio"
  p.description = %q{drop.io CLI interface}
  p.email = 'sergio@rubio.name'
  p.summary = "drop.io CLI interface"
  p.url = "http://github.com/rubiojr/iorb"
  p.remote_rdoc_dir = '' # Release to root
  p.extra_deps << [ "dropio",">= 0.9" ]
  p.developer('Sergio Rubio', 'sergio@rubio.name')
end
