class CreateDeviseFeatureFlagTables < ActiveRecord::Migration
  def self.up
    create_table :feature_flags do |t|
      t.string :key, null: false
      t.timestamps null: false
    end
    add_index :feature_flags, :key, unique: true

    create_table :feature_flag_users do |t|
      t.string :feature_flag_key, null: false
      t.integer :user_id, null: false
      t.timestamps null: false
    end
    add_index :feature_flag_users, [:feature_flag_key, :user_id], unique: true
    add_foreign_key :feature_flag_users, :feature_flags, column: :feature_flag_key, primary_key: :key
  end

  def self.down
    drop_table :feature_flag_users
    drop_table :feature_flags
  end
end