# BitcoinBarometer SDK exists test

import pytest
from bitcoinbarometer_sdk import BitcoinBarometerSDK


class TestExists:

    def test_should_create_test_sdk(self):
        testsdk = BitcoinBarometerSDK.test(None, None)
        assert testsdk is not None
