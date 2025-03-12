class Music < ApplicationRecord
  belongs_to :artist
  validates :title, :album_name, :genre, presence: true
  validates :title, uniqueness: true
  validates :genre, inclusion: {in: ['rnb', 'country', 'classic', 'rock', 'jazz']}
end
