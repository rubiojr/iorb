def delete_asset(drop_name, asset_name, force = false)
  HighLine.track_eof = false
  $stdout.sync = true
  details = IORB::DropManager.find(drop_name)
  regex = false
  if asset_name =~ /^\/.*\/$/
    regex = true
    asset_name = Regexp.new(asset_name[1..-2])
  end
  begin
    if details.nil?
      drop = Drop.find(drop_name)
    else
      drop = Drop.find(drop_name, details.admin_token)
    end
    to_delete = []
    drop.assets.each do |a|
      if regex
        (to_delete << a) if a.name =~ asset_name
      else
        (to_delete << a) if a.name == asset_name
      end
    end
    to_delete.each do |a|
      if force
        print "Deleting #{a.name}... "
        a.destroy!
        puts "done"
      else
        if agree("#{drop_name}:#{a.name} will be deleted, sure? (y/n) ")
          print "Deleting #{a.name}... "
          a.destroy!
          puts "done"
        end
      end
    end
    puts "\nNo matching asset found in drop #{drop_name}\n\n" if to_delete.empty?
  rescue Dropio::MissingResourceError
    $stderr.puts "Drop/Asset does not exist"
  rescue Dropio::AuthorizationError
    $stderr.puts "Authorization error. This drop is private or the admin token is invalid."
  end
end

def delete_drop(drop_name)
  HighLine.track_eof = false
  begin
    details = IORB::DropManager.find(drop_name)
    if details
      drop = Drop.find(drop_name, details.admin_token)
      if ask("Deleting #{drop_name}, sure? (y/n) ")
        drop.destroy
        details['destroyed'] = true
        details.save
        puts 'Destroyed.'
      end
    else
      $stderr.puts "No admin-token for #{drop_name}. I can't destroy it"
    end
  rescue Dropio::MissingResourceError
    $stderr.puts "Drop/Asset does not exist"
  rescue Dropio::AuthorizationError
    $stderr.puts "Authorization error. This drop is private or the admin token is invalid."
  end
end

command :destroy do |c|
  c.description = 'Destroy an existing drop/asset'
  c.option '--force', 'Do not ask for confirmation before destroying'
  c.when_called do |args, options|
    options.default :force => false
    param = args.first
    drop_name = nil
    asset = nil
    if param =~ /^\w+:.*/
      drop_name, asset = param.split(':')
      delete_asset(drop_name, asset, options.force)
    else
      drop_name = param
      delete_drop(drop_name)
    end
  end
end
