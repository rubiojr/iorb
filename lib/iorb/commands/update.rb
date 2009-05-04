command :update do |c|
  c.description = 'Update drop attributes'
  c.option '--expiration-length LENGTH', String, 'Drop expiration length'
  c.option '--save YES/NO', TrueClass, 'Save the drop info to the config file (defaut: yes)'
  c.option '--guests-can-comment YES/NO', String, 'Guest can add comments (defaut: yes)'
  c.option '--guests-can-add YES/NO', String, 'Guest can add to this drop (defaut: yes)'
  c.option '--guests-can-delete YES/NO', String, 'Guest can delete assets in this drop (defaut: yes)'
  c.option '--admin-password PASSWORD', String, 'Admin password to manage this drop (defaut: none)'
  c.option '--password PASSWORD', String, 'Password to access this drop (defaut: none)'
  c.option '--premium-code CODE', String, 'Premium code to apply to the drop (defaut: none)'
  c.when_called do |args, drop_options|
    drop_name = args.first
    begin
      details = IORB::DropManager.find(drop_name)
      drop = Drop.find(drop_name, details.admin_token )
      if drop_options.expiration_length
        drop.expiration_length = drop_options.expiration_length
      end
      if drop_options.guests_can_delete
        drop.guests_can_delete = (drop_options.guests_can_delete =~ /^yes|y$/ ? true : false)
      end
      if drop_options.guests_can_comment
        drop.guests_can_comment = (drop_options.guests_can_comment =~ /^yes|y$/ ? true : false)
      end
      if drop_options.guests_can_add
        drop.guests_can_add = (drop_options.guests_can_add =~ /^yes|y$/ ? true : false)
      end
      if drop_options.admin
        drop.admin_password = drop_options.admin_password
      end
      if drop_options.password
        if drop_options.password.chomp.strip.eql?('no')
          drop.password = nil
        else
          drop.password = drop_options.password
        end
      end
      if drop_options.premium
        drop.premium_code = drop_options.premium_code
      end
      drop.save
      details = IORB::DropDetails.build_from(drop)
      details.print
      details.save if drop_options.save
    rescue Dropio::MissingResourceError
      $stderr.puts "Drop/Asset does not exist"
    rescue Dropio::AuthorizationError => e
      $stderr.puts e.message
      $stderr.puts 'Error updating drop.'
    end
  end
end
