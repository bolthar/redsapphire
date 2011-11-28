
class SdlEventHandler

  def initialize(&block)
    @keyMap = {}
    @keyMap[SDL::Key::KP8] = :numpad8
    @keyMap[SDL::Key::KP9] = :numpad9
    @keyMap[SDL::Key::KP6] = :numpad6
    @keyMap[SDL::Key::KP3] = :numpad3
    @keyMap[SDL::Key::KP2] = :numpad2
    @keyMap[SDL::Key::KP1] = :numpad1
    @keyMap[SDL::Key::KP4] = :numpad4
    @keyMap[SDL::Key::KP7] = :numpad7
    @keyMap[SDL::Key::Q] = :q
    @keyMap[SDL::Key::I] = :i
    @keyMap[SDL::Key::G] = :g
    @callback = block
  end

  def get_input
    event = nil
    while !event
      event = Event.wait
      if event.kind_of? Event::KeyDown
        @callback.call(parse_event(event))
      end
      event = nil
    end
  end

  def loop
    get_input
  end

  private
  def parse_event(event)
    result = @keyMap[event.sym]
    return result
  end

end
