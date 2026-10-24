# BitcoinBarometer SDK feature factory

from bitcoinbarometer_sdk.feature.base_feature import BitcoinBarometerBaseFeature
from bitcoinbarometer_sdk.feature.ratelimit_feature import BitcoinBarometerRatelimitFeature
from bitcoinbarometer_sdk.feature.retry_feature import BitcoinBarometerRetryFeature
from bitcoinbarometer_sdk.feature.test_feature import BitcoinBarometerTestFeature
from bitcoinbarometer_sdk.feature.timeout_feature import BitcoinBarometerTimeoutFeature


_FEATURES = {
    "base": lambda: BitcoinBarometerBaseFeature(),
    "ratelimit": lambda: BitcoinBarometerRatelimitFeature(),
    "retry": lambda: BitcoinBarometerRetryFeature(),
    "test": lambda: BitcoinBarometerTestFeature(),
    "timeout": lambda: BitcoinBarometerTimeoutFeature(),
}


def _make_feature(name):
    factory = _FEATURES.get(name)
    if factory is not None:
        return factory()
    return _FEATURES["base"]()


# True when this SDK was generated with the named feature class - the
# constructor's tolerance for extend-carried features reads this (an
# active name with no generated class must not become a BaseFeature
# stray when an extend instance carries it).
def _has_feature(name):
    return name in _FEATURES
