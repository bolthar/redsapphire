

files = Dir.glob('test/RubyRogue.RogueCurses.Fixture/Fixtures/*.rb')
    files.each { |file|
        require file}