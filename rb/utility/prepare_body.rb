# BitcoinBarometer SDK utility: prepare_body
require_relative 'media'
module BitcoinBarometerUtilities
  PrepareBody = ->(ctx) {
    return nil unless ctx.op.input == "data"
    return BitcoinBarometerUtilities.raw_body(ctx.reqdata) if BitcoinBarometerUtilities.raw_request?(ctx.point)
    ctx.utility.transform_request.call(ctx)
  }
end
