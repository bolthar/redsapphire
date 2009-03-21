

class Headers
  def Headers.includeRequirements
    baseDir = Dir.pwd + '/lib/'
    doIncludeDirectory(baseDir + "/RubyRogue.Core")
    doIncludeDirectory(baseDir + "/RubyRogue.RogueSDL")
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