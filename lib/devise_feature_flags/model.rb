module Devise
  module Models
    # Allow for feature flags on Devise resources. Adds attribute:
    module DeviseFeatureFlags
      extend  ActiveSupport::Concern

      def has_feature_flag(flag)
        return true # TODO
      end

      def enable_feature_flag(flag)
        # TODO
      end

      def disable_feature_flag(flag)
        # TODO
      end
    end
  end
end
