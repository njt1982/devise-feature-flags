class CreateDeviseFeatureFlagsTables < ActiveRecord::Migration
  def self.up
    create_table :feature_flags_features do |t|
      t.string :key, null: false
      t.timestamps null: false
    end
    add_index :feature_flags_features, :key, unique: true

    create_table :feature_flags_users do |t|
      t.string :feature_flag_key, null: false
      t.integer :user_id, null: false
      t.timestamps null: false
    end
    add_index :feature_flags_users, [:feature_flag_key, :user_id], unique: true
    add_foreign_key :feature_flags_users, :feature_flags_features, column: :feature_flag_key, primary_key: :key
  end

  def self.down
    drop_table :feature_flags_users
    drop_table :feature_flags_features
  end
end