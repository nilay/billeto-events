class Event < ApplicationRecord
    has_many :event_votes, dependent: :destroy
    has_one :event_vote_counter, dependent: :destroy
end
