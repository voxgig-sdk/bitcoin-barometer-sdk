-- BitcoinBarometer SDK exists test

local sdk = require("bitcoin-barometer_sdk")

describe("BitcoinBarometerSDK", function()
  it("should create test SDK", function()
    local testsdk = sdk.test(nil, nil)
    assert.is_not_nil(testsdk)
  end)
end)
