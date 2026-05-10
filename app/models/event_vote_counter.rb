class EventVoteCounter < ApplicationRecord
    belongs_to :event
    validates :upvotes_count, :downvotes_count, presence: true
    validates :upvotes_count, :downvotes_count, numericality: { greater_than_or_equal_to: 0 }
end
