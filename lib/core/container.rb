
module Container
  include Enumerable

  def objects
    @objects ||= []
    return @objects
  end

  def each
    objects.each do |obj|
      yield(obj)
    end
  end

  def <<(obj)
    obj.owner = self
    objects << obj
  end

end
