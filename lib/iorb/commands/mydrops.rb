command :mydrops do |c|
  c.description = 'List managed drops'
  c.when_called do 
    IORB::DropManager.each do |d|
      puts d['name']
    end
  end
end
