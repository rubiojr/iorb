def send_to_drop(drop_name, asset_name, target_drop)
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
    to_copy = []
    drop.assets.each do |a|
      if regex
        (to_copy << a) if a.name =~ asset_name
      else
        (to_copy << a) if a.name == asset_name
      end
    end
    to_copy.each do |a|
      print "Copying #{a.name}... "
      a.send_to_drop(target_drop)
      puts "done"
    end
    puts "\nNo matching asset found in drop #{drop_name}\n\n" if to_copy.empty?
  rescue Dropio::MissingResourceError
    $stderr.puts "Drop/Asset does not exist"
  rescue Dropio::AuthorizationError
    $stderr.puts "Authorization error. This drop is private or the admin token is invalid."
  end
end

command :send_to_drop do |c|
  c.description = 'Sends an asset to another drop'
  c.option '--target-drop NAME', 'Target drop name (must accept files from guests)'
  c.when_called do |args, options|
    param = args.first
    drop_name = nil
    asset = nil
    if options.target_drop.nil?
      $stderr.puts '--target-drop not specified'
      abort
    end
    if param =~ /^\w+:.*/
      drop_name, asset = param.split(':')
      send_to_drop(drop_name, asset, options.target_drop)
    else
      $stderr.puts 'Invalid drop/asset.'
    end
  end
end
