class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
   	t.string :location
    t.string :tags
    t.bigint :user_id
    t.string :name
    t.integer :place_type
    t.string :property_type
    t.integer :room_number
    t.integer :bed_number
    t.integer :guest_number
    t.string :country
    t.string :state
    t.string :city
    t.integer :zipcode
    t.integer :price
    t.string :description
    t.boolean :verified, default: false
    t.string :image
    t.index ["user_id"], name: "index_listings_on_user_id"
	t.timestamps
    end
  end
end
