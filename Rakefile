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
  p.extra_deps << [ "highline",">= 1.0" ]
  p.extra_deps << [ "visionmedia-commander",">= 3.2" ]
  p.developer('Sergio Rubio', 'sergio@rubio.name')
end

task :publish_dev_gem do
  `scp pkg/*.gem dev.netcorex.org:/srv/www/dev.netcorex.org/gems/`
  `ssh dev.netcorex.org gem generate_index -d /srv/www/dev.netcorex.org/`
end
