
import { test, describe } from 'node:test'
import { equal } from 'node:assert'


import { BitcoinBarometerSDK } from '..'


describe('exists', async () => {

  test('test-mode', () => {
    const testsdk = BitcoinBarometerSDK.test()
    equal(testsdk instanceof BitcoinBarometerSDK, true,
      'BitcoinBarometerSDK.test() must return a client synchronously')
  })

})
