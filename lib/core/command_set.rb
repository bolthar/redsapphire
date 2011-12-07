
class CommandSet

  def initialize(level)
    @level = level
    @commands = {}
    @commands[:numpad8] = Move.new(0, -1)
    @commands[:numpad9] = Move.new(+1, -1)
    @commands[:numpad6] = Move.new(+1, 0)
    @commands[:numpad3] = Move.new(+1, +1)
    @commands[:numpad2] = Move.new(0, +1)
    @commands[:numpad1] = Move.new(-1, +1)
    @commands[:numpad4] = Move.new(-1, 0)
    @commands[:numpad7] = Move.new(-1, -1)
    @commands[:q]       = Quit.new
    @commands[:g]       = Get.new
    @commands[:a]       = Quaff.new
  end

  def handle(symbol)
    @commands[symbol].execute(@level) if @commands[symbol]
  end

end
