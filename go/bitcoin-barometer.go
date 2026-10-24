package voxgigbitcoinbarometersdk

import (
	"github.com/voxgig-sdk/bitcoin-barometer-sdk/go/core"
	"github.com/voxgig-sdk/bitcoin-barometer-sdk/go/entity"
	"github.com/voxgig-sdk/bitcoin-barometer-sdk/go/feature"
	_ "github.com/voxgig-sdk/bitcoin-barometer-sdk/go/utility"
)

// Type aliases preserve external API.
type BitcoinBarometerSDK = core.BitcoinBarometerSDK
type Context = core.Context
type Utility = core.Utility
type Feature = core.Feature
type Entity = core.Entity
type BitcoinBarometerEntity = core.BitcoinBarometerEntity
type StreamItem = core.StreamItem
type FetcherFunc = core.FetcherFunc
type Spec = core.Spec
type Result = core.Result
type Response = core.Response
type Operation = core.Operation
type Control = core.Control
type BitcoinBarometerError = core.BitcoinBarometerError

// BaseFeature from feature package.
type BaseFeature = feature.BaseFeature

func init() {
	core.NewBaseFeatureFunc = func() core.Feature {
		return feature.NewBaseFeature()
	}
	core.NewRatelimitFeatureFunc = func() core.Feature {
		return feature.NewRatelimitFeature()
	}
	core.NewRetryFeatureFunc = func() core.Feature {
		return feature.NewRetryFeature()
	}
	core.NewTestFeatureFunc = func() core.Feature {
		return feature.NewTestFeature()
	}
	core.NewTimeoutFeatureFunc = func() core.Feature {
		return feature.NewTimeoutFeature()
	}
	core.NewBadgeEntityFunc = func(client *core.BitcoinBarometerSDK, entopts map[string]any) core.BitcoinBarometerEntity {
		return entity.NewBadgeEntity(client, entopts)
	}
	core.NewBarometerEntityFunc = func(client *core.BitcoinBarometerSDK, entopts map[string]any) core.BitcoinBarometerEntity {
		return entity.NewBarometerEntity(client, entopts)
	}
}

// Constructor re-exports.
var NewBitcoinBarometerSDK = core.NewBitcoinBarometerSDK
var TestSDK = core.TestSDK
var NewContext = core.NewContext
var NewSpec = core.NewSpec
var NewResult = core.NewResult
var NewResponse = core.NewResponse
var NewOperation = core.NewOperation
var MakeConfig = core.MakeConfig
var SharedConfig = core.SharedConfig

// No-arg convenience constructors. Go has no default-argument syntax,
// so these aliases let callers write `sdk.New()` / `sdk.Test()`
// instead of `sdk.NewBitcoinBarometerSDK(nil)` / `sdk.TestSDK(nil, nil)`
// for the common no-options case.
func New() *BitcoinBarometerSDK  { return NewBitcoinBarometerSDK(nil) }
func Test() *BitcoinBarometerSDK { return TestSDK(nil, nil) }
var NewBaseFeature = feature.NewBaseFeature
var NewRatelimitFeature = feature.NewRatelimitFeature
var NewRetryFeature = feature.NewRetryFeature
var NewTestFeature = feature.NewTestFeature
var NewTimeoutFeature = feature.NewTimeoutFeature
