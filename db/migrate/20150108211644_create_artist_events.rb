class CreateArtistEvents < ActiveRecord::Migration
  def change
    create_table :artist_events do |t|
      t.integer :artist_id
      t.integer :user_id

      t.timestamps
    end
  end
end
