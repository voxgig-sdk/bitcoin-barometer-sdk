package core

var UtilityRegistrar func(u *Utility)

var NewBaseFeatureFunc func() Feature

var NewRatelimitFeatureFunc func() Feature

var NewRetryFeatureFunc func() Feature

var NewTestFeatureFunc func() Feature

var NewTimeoutFeatureFunc func() Feature

var NewBadgeEntityFunc func(client *BitcoinBarometerSDK, entopts map[string]any) BitcoinBarometerEntity

var NewBarometerEntityFunc func(client *BitcoinBarometerSDK, entopts map[string]any) BitcoinBarometerEntity

