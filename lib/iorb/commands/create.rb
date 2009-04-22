command :create do |c|
  c.description = 'Create a new drop'
  c.option '--expiration-length LENGTH', String, 'Drop expiration length'
  c.option '--save YES/NO', TrueClass, 'Save the drop info to the config file (defaut: yes)'
  c.option '--guest-can-comment YES/NO', TrueClass, 'Guest can add comments (defaut: yes)'
  c.option '--guest-can-add YES/NO', TrueClass, 'Guest can add to this drop (defaut: yes)'
  c.when_called do |args, options|
    drop_name = args.first
    options.default(
      :expiration_length => '1_WEEK_FROM_LAST_VIEW',
      :save => true,
      :guest_can_comment => true,
      :guest_can_add => false,
      :guest_can_delete => false
    )
    drop_options = {
      :name => drop_name,
      :expiration_length => options.expiration_length,
      :guests_can_add => options.guest_can_add,
      :guests_can_comment => options.guest_can_comment
    }
    begin
      drop = Drop.create(drop_options)
      details = IORB::DropDetails.build_from(drop)
      puts details.class
      details.print
      details.save if options.save
    rescue Dropio::AuthorizationError
      $stderr.puts 'Error creating drop.'
    end
  end
end
