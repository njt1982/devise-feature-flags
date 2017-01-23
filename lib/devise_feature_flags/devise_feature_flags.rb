require 'devise_feature_flags/version'
require 'devise_feature_flags/models/devise_feature_flag'
require 'active_record'
require 'devise'

module DeviseFeatureFlags
  class Feature < ::ActiveRecord::Base
    self.table_name = 'feature_flags_features'
    has_many :feature_users, primary_key: :key, foreign_key: :feature_flag_key
  end
  class FeatureUser < ::ActiveRecord::Base
    self.table_name = 'feature_flags_users'

    belongs_to :feature, primary_key: :key, foreign_key: :feature_flag_key
  end
end

Devise.add_module :devise_feature_flags#, :model => 'devise_feature_flags/models/devise_feature_flag'
