command :create do |c|
  c.description = 'Create a new drop'
  c.option '--expiration-length LENGTH', String, 'Drop expiration length'
  c.option '--save YES/NO', TrueClass, 'Save the drop info to the config file (defaut: yes)'
  c.option '--guests-can-comment YES/NO', String, 'Guest can add comments (defaut: yes)'
  c.option '--guests-can-add YES/NO', String, 'Guest can add to this drop (defaut: yes)'
  c.option '--guests-can-delete YES/NO', String, 'Guest can delete assets in this drop (defaut: yes)'
  c.option '--admin-password PASSWORD', String, 'Admin password to manage this drop (defaut: none)'
  c.option '--password PASSWORD', String, 'Password to access this drop (defaut: none)'
  c.option '--premium-code CODE', String, 'Premium code to apply to the drop (defaut: none)'
  c.when_called do |args, options|
    drop_name = args.first
    options.default(
      :expiration_length => '1_WEEK_FROM_LAST_VIEW',
      :save => true,
      :guests_can_comment => true,
      :guests_can_add => true,
      :guests_can_delete => true
    )
    drop_options = {
      :name => drop_name,
      :expiration_length => options.expiration_length,
      :guests_can_add => (options.guests_can_add =~ /^yes|y$/ ? true : false),
      :guests_can_comment => (options.guests_can_comment =~ /^yes|y$/ ? true : false),
      :guests_can_delete => (options.guests_can_delete =~ /^yes|y$/ ? true : false),
      :admin_password => options.admin_password,
      :password => options.password,
      :premium_code => options.premium_code
    }
    begin
      drop = Drop.create(drop_options)
      details = IORB::DropDetails.build_from(drop)
      details.print
      details['created-at'] = DateTime.now.to_s
      details.save if options.save
    rescue Dropio::AuthorizationError
      $stderr.puts 'Error creating drop.'
    end
  end
end
