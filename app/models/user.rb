class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :validatable,
          :jwt_authenticatable, jwt_revocation_strategy: self

  enum :gender, %w[female male others].index_by(&:itself)

  validates :gender, inclusion: {in: ['female', 'male', 'others']}
  validates :password, presence: true, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
  # validates :role, inclusion: {in: ['super_admin', 'artist_manager', 'artist']}
end
