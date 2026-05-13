module Vote
  class VoteEvent
    def initialize(clerk_user_id:, event_id:, vote_type:, ip:)
      @clerk_user_id = clerk_user_id
      @event_id = event_id
      @vote_type = vote_type
      @ip = ip
    end
  
    def call
      existing_vote = EventVote.find_by(
        clerk_user_id: @clerk_user_id,
        event_id: @event_id
      )

      # if the vote already exists, return
      return if existing_vote&.vote_type == @vote_type
        
  
      ActiveRecord::Base.transaction do

        vote = EventVote.upsert(
          {
            clerk_user_id: @clerk_user_id,
            event_id: @event_id,
            vote_type: @vote_type
          },
          unique_by: [:clerk_user_id, :event_id]
        )
  
        # @event.increment!(:upvotes_count)
  
        Rails.configuration.event_store.publish(
          EventVoted.new(
            data: {
              clerk_user_id: @clerk_user_id,
              event_id: @event_id,
              vote_type: @vote_type
            },
            metadata: {
              ip: @ip
            }
          )
        )
      end
    end
  end
end
