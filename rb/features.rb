# BitcoinBarometer SDK feature factory

require_relative 'feature/base_feature'
require_relative 'feature/ratelimit_feature'
require_relative 'feature/retry_feature'
require_relative 'feature/test_feature'
require_relative 'feature/timeout_feature'


module BitcoinBarometerFeatures
  def self.make_feature(name)
    case name
    when "base"
      BitcoinBarometerBaseFeature.new
    when "ratelimit"
      BitcoinBarometerRatelimitFeature.new
    when "retry"
      BitcoinBarometerRetryFeature.new
    when "test"
      BitcoinBarometerTestFeature.new
    when "timeout"
      BitcoinBarometerTimeoutFeature.new
    else
      BitcoinBarometerBaseFeature.new
    end
  end
end
