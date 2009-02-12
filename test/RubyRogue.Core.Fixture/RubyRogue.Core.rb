# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'test/unit' 

# Add your testcases here

files = Dir.glob('../test/RubyRogue.Core.Fixture/Fixtures/*.rb')   
    files.each { |file|
        require file}

