# To change this template, choose Tools | Templates
# and open the template in the editor.

# Add your testcases here

files = Dir.glob('test/RubyRogue.LevelBuilder.Fixture/Fixtures/*.rb')
    files.each { |file|
        require file}