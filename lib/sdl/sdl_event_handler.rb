
class SdlEventHandler

  def initialize()
    @keyMap = {}
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
