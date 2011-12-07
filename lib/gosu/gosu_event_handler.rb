require 'gosu'

class GosuEventHandler

  def initialize(&block)
    @keyMap = {}
    @keyMap[Gosu::KbNumpad8] = :numpad8
    @keyMap[Gosu::KbNumpad9] = :numpad9
    @keyMap[Gosu::KbNumpad6] = :numpad6
    @keyMap[Gosu::KbNumpad3] = :numpad3
    @keyMap[Gosu::KbNumpad2] = :numpad2
    @keyMap[Gosu::KbNumpad1] = :numpad1
    @keyMap[Gosu::KbNumpad4] = :numpad4
    @keyMap[Gosu::KbNumpad7] = :numpad7
    @keyMap[65431] = :numpad8
    @keyMap[65434] = :numpad9
    @keyMap[65432] = :numpad6
    @keyMap[65435] = :numpad3
    @keyMap[65433] = :numpad2
    @keyMap[65436] = :numpad1
    @keyMap[65430] = :numpad4
    @keyMap[65429] = :numpad7
    @keyMap[Gosu::KbQ] = :q
    @keyMap[Gosu::KbI] = :i
    @keyMap[Gosu::KbG] = :g
    @keyMap[Gosu::KbA] = :a
    @callback = block
  end

  def get_input(id)
    @callback.call(parse_event(id))
  end

  private
  def parse_event(event)
    result = @keyMap[event]
    return result
  end

end
