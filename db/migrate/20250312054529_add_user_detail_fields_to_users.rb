class AddUserDetailFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone, :string
    add_column :users, :dob, :date
    add_column :users, :gender, :string
    add_column :users, :address, :text
  end
end
