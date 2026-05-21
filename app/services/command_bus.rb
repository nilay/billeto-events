class CommandBus
  def initialize
    @handlers = {}
  end

  def register(command_class, handler)
    @handlers[command_class] = handler
  end

  def dispatch(command)
    handler = @handlers[command.class]
    raise "No handler registered for command #{command.class}" if handler.nil?
    handler.call(command)   
  end

end
