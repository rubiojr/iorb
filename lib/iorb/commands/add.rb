command :add do |c|
  c.description = 'Add files to a drop'
  c.option '--drop-name NAME', String, 'The target drop name'
  c.when_called do |args, options|
    if options.drop_name.nil?
      # add files to a new, unnamed drop
      drop_options = {
        :expiration_length => '1_WEEK_FROM_NOW'
      }
      print "Creating a new drop... "
      drop = Drop.create(drop_options)
      puts 'done'
      details = IORB::DropDetails.build_from(drop)
      drop_name = drop.name
      details.print
      details.save
      puts
    else
      # let's see if the manager knows the drop
      drop_name = options.drop_name
      details = IORB::DropManager.find(drop_name)
    end
    begin
      if details.nil?
        drop = Drop.find(drop_name)
      else
        drop = Drop.find(drop_name, details.admin_token)
      end
      args.each do |f|
        if File.exist?(f)
          drop.add_file(f)
          puts "File #{f} added."
        else
          $stderr.puts "File #{f} not found, skipping."
        end
      end
    rescue Dropio::MissingResourceError
      $stderr.puts "Drop/Asset does not exist"
    rescue Dropio::AuthorizationError
      $stderr.puts "Authorization error. This drop is private or the admin token is invalid."
    end
  end
end
