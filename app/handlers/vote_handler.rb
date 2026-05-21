class VoteHandler

  def call (command)
   # CommandBus.dispatch(SyncEventVoteCounterCommand.new(event_id: @event_id))
    ve = Vote::VoteEvent.new(
      event_id: command.event_id,
      clerk_user_id: command.clerk_user_id,
      vote_type: command.vote_type,
      ip: command.ip
    ).call

  end

end