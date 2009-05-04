command :info do |c|
  c.description = 'display drop/asset info'
  c.syntax = 'iorb info <drop_name>[:asset_name]'
  c.when_called do |args, options|
    if args.empty?
      $stderr.puts 'Needs drop name as an argument.'
      $stderr.puts c.syntax
    else
      begin
        drop_name = args.first
        if drop_name =~ /^\w+:.*/
          drop_name, asset = drop_name.split(':')
        end
        details = IORB::DropManager.find(drop_name)
        admin_token = nil
        if details
          admin_token = details.admin_token
        end
        drop = Drop.find(drop_name, admin_token)
        if asset
          assets = drop.assets
          found = false
          if assets.empty?
            $stderr.puts "No assets in #{drop_name}"
            abort
          else
            drop.assets.each do |a|
              if a.name.eql? asset
                found = true
                puts a.class
                puts "Name:           #{a.name}"
                puts "Hidden URL:     #{a.hidden_url}"
                puts "Type:           #{a.type}"
                puts "File size:      #{a.filesize}"
                puts "Created at:     #{a.created_at}"
              end
            end
          end
          $stderr.puts "Asset #{asset} not found in #{drop_name}" if not found
        else
          details = IORB::DropDetails.build_from(drop)
          details.save
          details.print
        end
      rescue Dropio::MissingResourceError
        $stderr.puts "Drop/Asset does not exist"
      rescue Dropio::AuthorizationError
        $stderr.puts "Authorization error. This drop is private or the admin token is invalid."
      end
    end
  end
end
