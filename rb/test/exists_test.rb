# BitcoinBarometer SDK exists test

require "minitest/autorun"
require_relative "../BitcoinBarometer_sdk"

class ExistsTest < Minitest::Test
  def test_create_test_sdk
    testsdk = BitcoinBarometerSDK.test(nil, nil)
    assert !testsdk.nil?
  end
end
