class CreateArtists < ActiveRecord::Migration[8.0]
  def change
    create_table :artists do |t|
      t.string :name
      t.date :dob
      t.string :gender
      t.text :address
      t.integer :first_release_year
      t.integer :no_of_albums_released

      t.timestamps
    end
  end
end
