
class Headers
  def Headers.includeRequirements
    baseDir = Dir.pwd
    doIncludeDirectory(baseDir + "/core")
    doIncludeDirectory(baseDir + "/sdl")
    doIncludeDirectory(baseDir + "/level_builder")
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


