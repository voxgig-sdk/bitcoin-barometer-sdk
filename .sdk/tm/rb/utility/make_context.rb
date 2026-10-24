# BitcoinBarometer SDK utility: make_context
require_relative '../core/context'
module BitcoinBarometerUtilities
  MakeContext = ->(ctxmap, basectx) {
    BitcoinBarometerContext.new(ctxmap, basectx)
  }
end
