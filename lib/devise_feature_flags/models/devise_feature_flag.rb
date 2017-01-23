require 'active_support/concern'
module Devise
  module Models
    # Allow for feature flags on Devise resources. Adds attribute:
    module DeviseFeatureFlag
      extend ::ActiveSupport::Concern
      included do
        has_many :feature_flag_users, class_name: 'DeviseFeatureFlags::FeatureUser'
        has_many :feature_flag_features, through: :feature_flag_users, source: :feature, class_name: 'DeviseFeatureFlags::Feature'
      end

      def get_feature_flag_user(flag)
        feature_flag_users.find_by_feature_flag_key(flag)
      end

      def has_feature_flag(flag)
        get_feature_flag_user(flag).present?
      end

      def enable_feature_flag(flag)
        feature_flag_users.create feature: DeviseFeatureFlags::Feature.find_by_key(flag)
      end

      def disable_feature_flag(flag)
        get_feature_flag_user(flag).destroy
      end
    end
  end
end
