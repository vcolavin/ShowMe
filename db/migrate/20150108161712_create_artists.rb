class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :name
      t.string :artist_code # the last.fm artist code

      t.timestamps
    end
  end
end
