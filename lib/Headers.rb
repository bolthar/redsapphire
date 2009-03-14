
require 'rubygems'
require 'needle'

class Headers
  def Headers.includeRequirements
    baseDir = Dir.pwd
    doIncludeDirectory(baseDir + "/RubyRogue.Core")
    doIncludeDirectory(baseDir + "/RubyRogue.RogueCurses")
    doIncludeDirectory(baseDir + "/RubyRogue.LevelBuilder")
  end

  def Headers.doIncludeDirectory(directory)
    files = Dir.glob(directory + "/*.rb")   
    files.each { |file|
        require file}
    nestedDirs = Dir.glob(directory + "/**/**")
    nestedDirs.each { |dir| doIncludeDirectory(dir)}
    
  end  
end

Headers.includeRequirements


