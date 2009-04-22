command :info do |c|
  c.description = 'display drop/asset info'
  c.when_called do |args, options|
    if args.empty?
      $stderr.puts 'Needs drop name as an argument.'
    else
      begin
        drop_name = args.first
        details = IORB::DropManager.find(drop_name)
        if details
          details.print
        else
          drop = Drop.find(args.first)
          IORB::DropDetails.build_from(drop).print
        end
      rescue Dropio::MissingResourceError
        $stderr.puts "Drop/Asset does not exist"
      rescue Dropio::AuthorizationError
        $stderr.puts "Authorization error. This drop is private or the admin token is invalid."
      end
    end
  end
end
