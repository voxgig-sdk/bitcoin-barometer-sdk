# BitcoinBarometer SDK utility registration
require_relative '../core/utility_type'
require_relative 'clean'
require_relative 'done'
require_relative 'make_error'
require_relative 'feature_add'
require_relative 'feature_hook'
require_relative 'feature_init'
require_relative 'fetcher'
require_relative 'make_fetch_def'
require_relative 'make_context'
require_relative 'make_options'
require_relative 'make_request'
require_relative 'make_response'
require_relative 'make_result'
require_relative 'make_point'
require_relative 'make_spec'
require_relative 'make_url'
require_relative 'param'
require_relative 'prepare_auth'
require_relative 'prepare_body'
require_relative 'prepare_headers'
require_relative 'prepare_method'
require_relative 'prepare_params'
require_relative 'prepare_path'
require_relative 'prepare_query'
require_relative 'graphql'
require_relative 'result_basic'
require_relative 'result_body'
require_relative 'result_headers'
require_relative 'transform_request'
require_relative 'transform_response'

BitcoinBarometerUtility.registrar = ->(u) {
  u.clean = BitcoinBarometerUtilities::Clean
  u.clean_add = BitcoinBarometerUtilities::CleanAdd
  u.clean_explain = BitcoinBarometerUtilities::CleanExplain
  u.done = BitcoinBarometerUtilities::Done
  u.make_error = BitcoinBarometerUtilities::MakeError
  u.feature_add = BitcoinBarometerUtilities::FeatureAdd
  u.feature_hook = BitcoinBarometerUtilities::FeatureHook
  u.feature_init = BitcoinBarometerUtilities::FeatureInit
  u.fetcher = BitcoinBarometerUtilities::Fetcher
  u.make_fetch_def = BitcoinBarometerUtilities::MakeFetchDef
  u.make_context = BitcoinBarometerUtilities::MakeContext
  u.make_options = BitcoinBarometerUtilities::MakeOptions
  u.make_request = BitcoinBarometerUtilities::MakeRequest
  u.make_response = BitcoinBarometerUtilities::MakeResponse
  u.make_result = BitcoinBarometerUtilities::MakeResult
  u.make_point = BitcoinBarometerUtilities::MakePoint
  u.make_spec = BitcoinBarometerUtilities::MakeSpec
  u.make_url = BitcoinBarometerUtilities::MakeUrl
  u.param = BitcoinBarometerUtilities::Param
  u.prepare_auth = BitcoinBarometerUtilities::PrepareAuth
  u.prepare_body = BitcoinBarometerUtilities::PrepareBody
  u.prepare_headers = BitcoinBarometerUtilities::PrepareHeaders
  u.prepare_method = BitcoinBarometerUtilities::PrepareMethod
  u.prepare_params = BitcoinBarometerUtilities::PrepareParams
  u.prepare_path = BitcoinBarometerUtilities::PreparePath
  u.prepare_query = BitcoinBarometerUtilities::PrepareQuery
  u.graphql_body = BitcoinBarometerUtilities::GraphqlBody
  u.graphql_errors = BitcoinBarometerUtilities::GraphqlErrors
  u.result_basic = BitcoinBarometerUtilities::ResultBasic
  u.result_body = BitcoinBarometerUtilities::ResultBody
  u.result_headers = BitcoinBarometerUtilities::ResultHeaders
  u.transform_request = BitcoinBarometerUtilities::TransformRequest
  u.transform_response = BitcoinBarometerUtilities::TransformResponse
}
