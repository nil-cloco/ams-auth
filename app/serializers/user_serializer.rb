class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :first_name, :last_name, :email, :gender, :phone, :dob, :address, :created_at, :role
  attribute :created_date do |user|
    user.created_at && user.created_at.strftime("%m/%d/%Y")
  end
end
