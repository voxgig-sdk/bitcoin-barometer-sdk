import { describe, test } from 'node:test'
import { SDK } from '..'
import { runDefinitionPoint } from './definition-runner'
import { isControlSkipped } from './utility'


// Generated from the API definition, not from the model this SDK was built
// from: the route, the declared query parameters, the credential the security
// scheme names, and the definition's own response example.
const PLAN: any[] = [
  {
    "entity": "badge",
    "accessor": "Badge",
    "op": "load",
    "method": "GET",
    "path": "/badge.json",
    "args": [],
    "select": {},
    "headers": [],
    "cookies": [],
    "responseMedia": [
      "application/json"
    ],
    "query": [],
    "queryArgs": [],
    "auth": null,
    "status": 200,
    "sample": {
      "schemaVersion": 1,
      "label": "x",
      "message": "x",
      "color": "x"
    },
    "idField": "id"
  },
  {
    "entity": "barometer",
    "accessor": "Barometer",
    "op": "list",
    "method": "GET",
    "path": "/barometer.json",
    "args": [],
    "select": {},
    "headers": [],
    "cookies": [],
    "responseMedia": [
      "application/json"
    ],
    "query": [],
    "queryArgs": [],
    "auth": null,
    "status": 200,
    "sample": {
      "score": 24,
      "heatScore": 1,
      "zone": "Chill",
      "zoneBands": [
        {
          "zone": "x",
          "min": 1,
          "max": 1
        }
      ],
      "computedAt": "2026-01-01T00:00:00Z",
      "degraded": [
        "x"
      ],
      "indicators": {
        "monthlyRSI": 1,
        "mayerMultiple": "x",
        "piCycleProximity": 1,
        "mvrvZScore": 1,
        "nupl": 1,
        "puellMultiple": 1,
        "twoYearHighProximity": 1,
        "roc90": 1,
        "fearAndGreed": 1,
        "searchInterestHeat": 1,
        "searchInterest": 1
      },
      "indicatorHeats": {},
      "price": {
        "usd": 1,
        "change24hPct": 1,
        "change7dPct": 1,
        "lastHourlyAt": "2026-01-01T00:00:00Z",
        "asOf": "2026-01-01T00:00:00Z"
      },
      "attribution": {},
      "methodology": "x",
      "imageUrl": "x",
      "app": "x",
      "license": "x"
    },
    "idField": "id"
  }
]


describe('definition', () => {
  for (const point of PLAN) {
    test(point.entity + '.' + point.op + ' ' + point.method + ' ' + point.path, async (t) => {
      const control = isControlSkipped('entityOp', point.entity + '.' + point.op, 'definition')
      if (control.skip) {
        t.skip(control.reason || 'skipped via sdk-test-control.json')
        return
      }
      await runDefinitionPoint(SDK, point)
    })
  }
})
