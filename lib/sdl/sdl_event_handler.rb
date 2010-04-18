
class SdlEventHandler

  def initialize()
    @keyMap = {}
    @keyMap[SDL::Key::KP8] = {:method => :move, :parameters => Direction.Up}
    @keyMap[SDL::Key::KP9] = {:method => :move, :parameters => Direction.UpRight}
    @keyMap[SDL::Key::KP6] = {:method => :move, :parameters => Direction.Right}
    @keyMap[SDL::Key::KP3] = {:method => :move, :parameters => Direction.DownRight}
    @keyMap[SDL::Key::KP2] = {:method => :move, :parameters => Direction.Down}
    @keyMap[SDL::Key::KP1] = {:method => :move, :parameters => Direction.DownLeft}
    @keyMap[SDL::Key::KP4] = {:method => :move, :parameters => Direction.Left}
    @keyMap[SDL::Key::KP7] = {:method => :move, :parameters => Direction.UpLeft}
    @keyMap[SDL::Key::Q] = {:method => :quit}
    @keyMap[SDL::Key::I] = {:method => :inventory}
    @keyMap[SDL::Key::G] = {:method => :gold}
  end

  def get_input
    event = nil
    while !event
      event = Event.wait
      if event.kind_of? Event::KeyDown
        return parse_event(event)
      end
      event = nil
    end
  end

  private
  def parse_event(event)
    result = @keyMap[event.sym]
    return result
  end

end
