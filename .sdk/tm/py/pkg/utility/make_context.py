# BitcoinBarometer SDK utility: make_context

from projectname_sdk.core.context import BitcoinBarometerContext


def make_context_util(ctxmap, basectx):
    return BitcoinBarometerContext(ctxmap, basectx)
