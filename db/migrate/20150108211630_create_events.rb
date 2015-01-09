class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.text :venue
      t.text :headliner
      t.datetime :date
      t.integer :longitude
      t.integer :latitude
      t.text :url

      t.timestamps
    end
  end
end
