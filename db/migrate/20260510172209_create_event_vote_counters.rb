class CreateEventVoteCounters < ActiveRecord::Migration[8.1]
  def change
    create_table :event_vote_counters do |t|
      t.references :event, null: false, foreign_key: true
      t.integer :upvotes_count, default: 0
      t.integer :downvotes_count, default: 0
      t.timestamps
    end
  end
end
