require 'open-uri'

command :download do |c|
  c.description = 'Download assets from the drop rss feed'
  c.option '--dest-dir DIR', 'Destination directory where the files will be downloaded'
  c.option '--available', 'List the files that can be downloaded'
  c.syntax = 'iorb download <drop_name>[:asset_regexp]'
  c.when_called do |args, options|
    if args.empty?
      $stderr.puts 'Needs drop name as an argument.'
      $stderr.puts c.syntax
    else
      begin
        drop_name = args.first
        if drop_name =~ /^\w+:.*/
          drop_name, asset_regex = drop_name.split(':')
          asset_regex = Regexp.new(asset_regex)
        else
          asset_regex = /.*/
        end
        details = IORB::DropManager.find(drop_name)
        admin_token = nil
        if details
          admin_token = details.admin_token
        end
        drop = Drop.find(drop_name, admin_token)
        # print only
        if options.available
          drop.each_file do |url|
            puts url.split('/').last if url =~ asset_regex
          end
        else
          $stdout.sync = true
          drop.each_file do |url|
            if url =~ asset_regex
              fname = url.split('/').last
              base_dir = options.dest_dir || './'
              dfile = File.join(base_dir, fname)
              fcount = 0
              while File.exist?(dfile)
                dfile = dfile + ".#{fcount + 1}"
                fcount += 1
              end
              print "Downloading #{fname}... "
              File.open(dfile, 'w') do |newf|
                open(url) do |stream|
                  newf.write stream.read
                end
              end
              puts 'Done'
            end
          end
        end
      rescue Dropio::MissingResourceError
        $stderr.puts "Drop/Asset does not exist"
      rescue Dropio::AuthorizationError
        $stderr.puts "Authorization error. This drop is private or the admin token is invalid."
      end
    end
  end
end
