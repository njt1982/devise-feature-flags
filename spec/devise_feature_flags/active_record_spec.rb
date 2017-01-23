require 'spec_helper'
require 'generators/devise_feature_flags/templates/migration'


RSpec.describe 'Active Record Integration' do

  before(:each) do
    CreateDeviseFeatureFlagsTables.up
  end

  after(:each) do
    CreateDeviseFeatureFlagsTables.down
  end


  context 'Features' do
    let(:feature_key) { 'test' }
    let(:feature) { DeviseFeatureFlags::Feature.create key: feature_key }

    it 'Can create a Feature' do
      expect { feature }.to change(DeviseFeatureFlags::Feature, :count).by 1
    end

    context 'FeatureUsers' do
      let(:user) { User.create name: 'Joe Bloggs', email: 'joe@example.com', role: 'admin' }
      let(:feature_user) { DeviseFeatureFlags::FeatureUser.create feature_flag_key: feature.key, user_id: user.id }

      it 'Can create a User' do
        expect { feature_user }.to change(DeviseFeatureFlags::FeatureUser, :count).by 1
      end

      it 'Can create a User via the Feature relationship' do
        expect {
          feature.feature_users.create user_id: user.id
        }.to change(DeviseFeatureFlags::FeatureUser, :count).by 1
      end

      it 'Creating a user changes the feature users count' do
        expect {
          feature.feature_users.create user_id: user.id
        }.to change(feature.feature_users, :count).from(0).to(1)
      end

      it 'A user can reference its feature correctly' do
        expect(feature_user.feature).to eq feature
      end

      context 'Users' do
        # Trigger feature_user (and therefore feature and user) to exist before running each test.
        before(:each) { feature_user }
        it 'can get feature users a user has' do
          expect(user.feature_flag_users).to include feature_user
        end

        it 'can get features a user has' do
          expect(user.feature_flag_features).to include feature
        end

        it 'can check if a user has a feature' do
          expect(user.has_feature_flag(feature_key)).to eq true
        end

        it 'can check if a user doest not have a non-existent feature' do
          expect(user.has_feature_flag('wibble')).to eq false
        end

        it 'can disable a feature flag on a user' do
          expect { user.disable_feature_flag(feature_key) }.to change { user.has_feature_flag(feature_key) }.from(true).to(false)
        end

        it 'can enable a new feature on a user' do
          DeviseFeatureFlags::Feature.create key: 'new_feature'
          expect { user.enable_feature_flag('new_feature') }.to change { user.has_feature_flag('new_feature') }.from(false).to(true)
        end
      end
    end
  end
end