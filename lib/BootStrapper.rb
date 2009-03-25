
require 'Headers.rb'

include LevelBuilder
include LevelBuilder::Workers
include Core
include Core::Elements
include SDLWrapper

srand(Date.new.hash)
mediator = Mediator.new
mediator.start

