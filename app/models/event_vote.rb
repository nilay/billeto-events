class EventVote < ApplicationRecord
    belongs_to :event
    validates :clerk_user_id, presence: true
    validates :vote_type, presence: true
    validates :vote_type, inclusion: { in: %w[upvote downvote] }    
end
