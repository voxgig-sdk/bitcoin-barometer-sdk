

import Path from 'node:path'
import * as Fs from 'node:fs'

import { test, describe, afterEach } from 'node:test'
import assert from 'node:assert'
import { createLiveTransport } from '../../live-runner'
import { runLiveEntity } from '../../live-entity'


import { BitcoinBarometerSDK, BaseFeature, config, stdutil } from '../../..'

import {
  envOverride,
  liveClientOptions,
  liveDelay,
  loadEnvLocal,
  makeCtrl,
  makeMatch,
  makeReqdata,
  makeStepData,
  makeValid,
  maybeSkipControl,
} from '../../utility'


loadEnvLocal(__dirname + '/../../../.env.local')


describe('BarometerEntity', async () => {

  // Per-test live pacing. Delay is read from sdk-test-control.json's
  // `test.live.delayMs`; only sleeps when BITCOIN_BAROMETER_TEST_LIVE=TRUE.
  afterEach(liveDelay('BITCOIN_BAROMETER_TEST_LIVE'))

  test('instance', async () => {
    const testsdk = BitcoinBarometerSDK.test()
    const ent = testsdk.Barometer()
    assert(null != ent)
  })


  class FailHook extends BaseFeature {
    name = 'failhook'
    version = '0.0.1'
    active = true
    unexpected = 0
    init() { }
    PreSpec() { throw new Error('barometer hook failed') }
    PreUnexpected() { this.unexpected++ }
  }

  test('stream-error', async () => {
    const offline = { net: { offline: true } }
    await assert.rejects(async () => {
      for await (const _item of BitcoinBarometerSDK.test(offline).Barometer().stream('list')) { }
    }, /offline/)

    for await (const _item of BitcoinBarometerSDK.test(offline).Barometer()
      .stream('list', undefined, { ctrl: { throw: false } })) { }

    if (null != (config as any).feature?.rbac) {
      const denied = BitcoinBarometerSDK.test(undefined, { feature: { rbac: { active: true, deny: true } } })
      await assert.rejects(async () => {
        for await (const _item of denied.Barometer().stream('list')) { }
      }, (err: any) => 'rbac_denied' === err.code)
    }
  })

  test('stream-ctrl', async () => {
    const explain: any = {}
    const ctrl: any = { explain }
    for await (const _item of BitcoinBarometerSDK.test().Barometer().stream('list', undefined, { ctrl })) { }
    assert.deepStrictEqual(Object.keys(ctrl), ['explain'])
    assert(explain === ctrl.explain && 0 < Object.keys(explain).length)
  })

  test('unexpected', async () => {
    const hook = new FailHook()
    const client = new BitcoinBarometerSDK({ feature: { test: { active: true } }, extend: [hook] })
    await assert.rejects(client.Barometer().list(), /hook failed/)
    assert(0 < hook.unexpected)

    const fired = hook.unexpected
    assert.strictEqual(await client.Barometer().list(undefined, { throw: false }), undefined)
    assert(fired < hook.unexpected)
  })

  test('validate', async (t) => {
    if (null == (config as any).feature?.validate) {
      t.skip('feature not present in this SDK: validate')
      return
    }
    const client = BitcoinBarometerSDK.test(undefined, { feature: { validate: { active: true } } })
    await assert.rejects(client.Barometer().list({"max":"x"} as any),
      (err: any) => 'validate_failed' === err.code)
  })



  test('basic', async (t) => {

    const live = 'TRUE' === process.env.BITCOIN_BAROMETER_TEST_LIVE
    for (const op of ['list']) {
      if (!live && maybeSkipControl(t, 'entityOp', 'barometer.' + op, live)) return
    }

    
    const setup = basicSetup()
    if (setup.live) {
      return runLiveEntity(setup, {"active":true,"alias":{"field":{}},"fields":{"max":{"a":true,"h":"Max","n":"max","r":false,"sh":"Highest score in the zone.","t":"`$INTEGER`","key$":"max","index$":0},"min":{"a":true,"h":"Min","n":"min","r":false,"sh":"Lowest score in the zone.","t":"`$INTEGER`","key$":"min","index$":1},"zone":{"a":true,"h":"Zone","n":"zone","r":false,"sh":"Zone name.","t":"`$STRING`","key$":"zone","index$":2}},"name":"barometer","op":{"list":{"input":"data","name":"list","points":[{"a":true,"co":{"id":"GET /barometer.json","source":"openapi3","version":2},"g":{},"k":"http","m":"GET","o":"/barometer.json","q":{},"r":{},"rs":{"kind":"json","media":"application/json"},"s":[{"lit":"barometer.json"}],"t":{"req":"`reqdata`","res":"`body`"},"index$":0}],"key$":"list"}},"relations":{"ancestors":[]},"key$":"barometer","name__orig":"barometer","Name":"Barometer","name_":"barometer","name-":"barometer","NAME":"BAROMETER","index$":1}, {"active":true,"entity":"barometer","key$":"BasicBarometerFlow","kind":"basic","name":"BasicBarometerFlow","param":{},"step":[{"a":true,"d":{},"i":{},"m":{},"o":"list","s":[],"v":[{"apply":"ItemExists","def":{"ref":"barometer_ref01"}}],"index$":0}]}, 'Barometer', {"GET /barometer.json":{"protocol":"http","parameters":[]}}, { strict: LIVE_STRICT, t })
    }
    const client = setup.client
    const struct = setup.struct

    const isempty = struct.isempty
    const select = struct.select

    let barometer_ref01_data = Object.values(setup.data.existing.barometer)[0] as any

    // LIST
    const barometer_ref01_ent = client.Barometer()
    const barometer_ref01_match: any = {}

    const barometer_ref01_list = (await barometer_ref01_ent.list(barometer_ref01_match)).map((e: any) => e.data())


  })
})



// main.kit.test.live.strict is true (the default is true): a live
// request that fails, or a live test missing an input it needs,
// fails the test.
// An account with no record for a test to read skips it either way.
const LIVE_STRICT = true

function basicSetup(extra?: any) {
  // TODO: fix test def options
  const options: any = {} // null

  // TODO: needs test utility to resolve path
  const entityDataFile =
    Path.resolve(__dirname, 
      '../../../../.sdk/test/entity/barometer/BarometerTestData.json')

  // TODO: file ready util needed?
  const entityDataSource = Fs.readFileSync(entityDataFile).toString('utf8')

  // TODO: need a xlang JSON parse utility in voxgig/struct with better error msgs
  const entityData = JSON.parse(entityDataSource)

  options.entity = entityData.existing

  let client = BitcoinBarometerSDK.test(options, extra)
  const struct = client.utility().struct
  const merge = struct.merge
  const transform = struct.transform

  let idmap = transform(
    ['barometer01','barometer02','barometer03'],
    {
      '`$PACK`': ['', {
        '`$KEY`': '`$COPY`',
        '`$VAL`': ['`$FORMAT`', 'upper', '`$COPY`']
      }]
    })

  const env = envOverride({
    'BITCOIN_BAROMETER_TEST_BAROMETER_ENTID': idmap,
    'BITCOIN_BAROMETER_TEST_LIVE': 'FALSE',
    'BITCOIN_BAROMETER_TEST_EXPLAIN': 'FALSE',
  })

  idmap = env['BITCOIN_BAROMETER_TEST_BAROMETER_ENTID']

  const live = 'TRUE' === env.BITCOIN_BAROMETER_TEST_LIVE

  const transport = createLiveTransport()
  if (live) {
    const rawIds = process.env['BITCOIN_BAROMETER_TEST_BAROMETER_ENTID']
    idmap = rawIds && rawIds.trim() ? JSON.parse(rawIds) : {}
    if (!idmap || Array.isArray(idmap) || typeof idmap !== 'object') {
      throw new Error('Live ENTID must be a JSON object')
    }
    client = new BitcoinBarometerSDK(merge([
      // FIRST, so the generated fields below win: sdk-test-control.json's
      // test.client.options adds to the live client, it does not redirect it.
      liveClientOptions(),
      {
      },
      // 'extra || {}', not a bare 'extra': struct.merge returns UNDEFINED when the
      // last entry is undefined, and basicSetup is normally called with no
      // argument at all - so a bare 'extra' silently discarded the apikey
      // and server values above and handed the SDK undefined. Harmless
      // while there was nothing in that object; not harmless now.
      extra || {},
      { system: { fetch: transport.fetch } }
    ]))
  }

  const setup = {
    idmap,
    env,
    options,
    client,
    struct,
    data: entityData,
    explain: 'TRUE' === env.BITCOIN_BAROMETER_TEST_EXPLAIN,
    live,
    transport,
    now: Date.now(),
  }

  return setup
}
  
