class UpvoteCommand
  attr_reader :event_id, :clerk_user_id, :ip, :vote_type

  def initialize(event_id:, clerk_user_id:, ip:)
    @event_id = event_id
    @clerk_user_id = clerk_user_id
    @ip = ip
    @vote_type = EventVote.vote_types[:upvote]
  end
end