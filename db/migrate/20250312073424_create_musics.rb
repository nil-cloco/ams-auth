class CreateMusics < ActiveRecord::Migration[8.0]
  def change
    create_table :musics do |t|
      t.references :artist, null: false, foreign_key: true
      t.string :title
      t.string :album_name
      t.string :genre

      t.timestamps
    end
  end
end
