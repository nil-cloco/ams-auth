class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  enum :role, {super_admin: 'super_admin', artist_manager: 'artist_manager', artist: 'artist'}
  devise :database_authenticatable, :registerable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self

  validates :password, presence: true, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
  validates :gender, inclusion: {in: ['f', 'm', 'o']}
  validates :role, inclusion: {in: ['super_admin', 'artist_manager', 'artist']}
end
