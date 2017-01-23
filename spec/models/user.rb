require 'devise'
require 'devise_feature_flags/devise_feature_flags'

class User < ActiveRecord::Base
  devise :devise_feature_flags
end