class CreateAdventures < ActiveRecord::Migration
  def change
    create_table :adventures do |t|
      t.string :name
      t.string :address
      t.string :length
      t.string :season
      t.string :description
      t.string :image_url
      t.integer :user_id
    end
  end
end
