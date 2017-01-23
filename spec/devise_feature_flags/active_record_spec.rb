require 'spec_helper'
require 'generators/devise_feature_flags/templates/migration'

# Dont output the ActiveRecord Migration logging during tests.
ActiveRecord::Migration.verbose = false

# Unremark me if you need to see SQL Query logs during testing (for debugging purposes)
# ActiveRecord::Base.logger = Logger.new(STDOUT) if defined?(ActiveRecord::Base)


RSpec.describe 'Active Record Integration' do

  before(:all) do
    ActiveRecord::Base.establish_connection(adapter: 'sqlite3',
                                            database: ':memory:')
  end

  before(:each) do
    CreateDeviseFeatureFlagsTables.up
  end

  after(:each) do
    CreateDeviseFeatureFlagsTables.down
  end


  context 'Features' do
    it 'Can create a Feature' do
      expect { DeviseFeatureFlags::Feature.create key: 'test' }.to change(DeviseFeatureFlags::Feature, :count).by 1
    end
  end


  context 'Users' do
    let(:feature) { DeviseFeatureFlags::Feature.create key: 'test' }

    it 'Can create a User' do
      expect {
        DeviseFeatureFlags::FeatureUser.create feature_flag_key: 'test', user_id: 0
      }.to change(DeviseFeatureFlags::FeatureUser, :count).by 1
    end

    it 'Can create a User via the Feature relationship' do
      expect {
        feature.feature_users.create user_id: 0
      }.to change(DeviseFeatureFlags::FeatureUser, :count).by 1
    end

    it 'Creating a user changes the feature users count' do
      expect {
        feature.feature_users.create user_id: 0
      }.to change(feature.feature_users, :count).from(0).to(1)
    end

    it 'A user can reference its feature correctly' do
      user = DeviseFeatureFlags::FeatureUser.create feature_flag_key: feature.key, user_id: 0
      expect(user.feature).to eq feature
    end
  end
end