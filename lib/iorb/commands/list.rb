command :list do |c|
  c.description = 'list drop assets'
  c.option '--filter REGEX', String, 'Display only matched assets'
  c.option '--detailed', 'Display extra info'
  c.when_called do |args, options|
    filter = options.filter || '.*'
    drop_name = args[0]
    details = IORB::DropManager.find(drop_name)
    begin
      if details
        drop = Drop.find(drop_name, details.admin_token)
      else
        drop = Drop.find(drop_name)
      end
    rescue Dropio::MissingResourceError
      $stderr.puts "Drop/Asset does not exist"
    rescue Dropio::AuthorizationError
      $stderr.puts "Authorization error. This drop is private or the admin token is invalid."
    end
    assets = drop.assets
    if assets.empty?
      puts "No assets in #{drop_name}"
    else
      found = []
      drop.assets.each do |a|
        if filter =~ /^type:.*$/
          (found << a) if a.type == (filter.split(':').last || '')
        else
          (found << a) if a.name =~ Regexp.new(filter)
        end
      end
      found.each do |a|
        if options.detailed
          a.print_details
          puts
        else
          puts a.name
        end
      end
    end
  end
end
