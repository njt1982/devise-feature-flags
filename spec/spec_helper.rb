$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'devise_feature_flags/devise_feature_flags'

RSpec.configure do |config|
  config.before(:example) do
    # Anything we wanna do before each test...
  end

  config.disable_monkey_patching!

  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
end
