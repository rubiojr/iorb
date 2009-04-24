command :info do |c|
  c.description = 'display drop/asset info'
  c.when_called do |args, options|
    if args.empty?
      $stderr.puts 'Needs drop name as an argument.'
    else
      begin
        drop_name = args.first
        details = IORB::DropManager.find(drop_name)
        admin_token = nil
        admin_token = details.admin_token if details
        drop = Drop.find(args.first, admin_token)
        details = IORB::DropDetails.build_from(drop)
        details.save
        details.print
      rescue Dropio::MissingResourceError
        $stderr.puts "Drop/Asset does not exist"
      rescue Dropio::AuthorizationError
        $stderr.puts "Authorization error. This drop is private or the admin token is invalid."
      end
    end
  end
end
