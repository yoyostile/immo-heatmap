class AddApartments < ActiveRecord::Migration
  def change
    create_table :apartments do |t|
      t.string  :title
      t.string  :url
      t.string  :address
      t.integer :rent
      t.integer :size
      t.integer :rooms
      t.integer :is24_id
      t.float   :latitude
      t.float   :longitude
      t.timestamps
    end
  end
end
