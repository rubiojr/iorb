def mail_asset(drop_name, asset_name, emails, message = nil)
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
    to_mail = []
    drop.assets.each do |a|
      if regex
        (to_mail << a) if a.name =~ asset_name
      else
        (to_mail << a) if a.name == asset_name
      end
    end
    to_mail.each do |a|
      print "Emailing #{a.name}... "
      a.send_to_emails(emails, message)
      puts "done"
    end
    puts "\nNo matching asset found in drop #{drop_name}\n\n" if to_mail.empty?
  rescue Dropio::MissingResourceError
    $stderr.puts "Drop/Asset does not exist"
  rescue Dropio::AuthorizationError
    $stderr.puts "Authorization error. This drop is private or the admin token is invalid."
  end
end

command :mail do |c|
  c.description = 'Email an asset'
  c.option '--addresses ADDRESSES', 'Destination email addresses (separated by comma)'
  c.option '--message MESSAGE', 'Optional message'
  c.when_called do |args, options|
    if options.addresses.nil?
      $stderr.puts 'No email specified. --addresses is required'
      abort
    end
    param = args.first
    drop_name = nil
    asset = nil
    if param =~ /^\w+:.*/
      drop_name, asset = param.split(':')
      emails = options.addresses.split(',')
      mail_asset(drop_name, asset, emails, options.message)
    else
      $stderr.puts 'Invalid drop/asset.'
    end
  end
end
