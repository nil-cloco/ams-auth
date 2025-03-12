class Artist < ApplicationRecord
    has_many :music, dependent: :destroy
    validates :name, :dob, :gender, :first_release_year, :no_of_albums_released, presence: true
    validates :gender, inclusion: {in: ['f', 'm', 'o']}
end
