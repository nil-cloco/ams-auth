class AddTimestampsToUsers < ActiveRecord::Migration[8.0]
  def self.up
    change_table :users do |t|
      t.timestamps
    end
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end

