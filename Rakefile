require 'rake'
$:.unshift(File.dirname(__FILE__) + "/lib")
require 'hoe'

IORB_VERSION = '0.1'

Hoe.new('iorb', IORB_VERSION) do |p|
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
