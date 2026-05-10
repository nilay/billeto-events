class CreateEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :events do |t|
      t.string :external_id, index: { unique: true }, null: false
      t.string :name, null: false
      t.datetime :start_at, index: true
      t.text :description
      t.string :image_url
      t.timestamps
    end
  end
end
