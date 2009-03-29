

class MediatorFixture < Test::Unit::TestCase

  def test_ctor_always_callRegistryWithRightArguments
    registry = mock()
    registry.expects(:eventHandler)
    registry.expects(:adapter)
    registry.expects(:dumper)
    registry.expects(:architect)
    Mediator.new(registry)
  end
end
