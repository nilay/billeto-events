Rails.application.config.to_prepare do
    command_bus = CommandBus.new

    command_bus.register(UpvoteCommand,  VoteHandler.new)
    command_bus.register(DownvoteCommand,  VoteHandler.new)
  
    Rails.application.config.command_bus = command_bus
end