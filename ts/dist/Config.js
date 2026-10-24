"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.FEATURE_PLUGINS = exports.config = void 0;
const RatelimitFeature_1 = require("./feature/ratelimit/RatelimitFeature");
const RetryFeature_1 = require("./feature/retry/RetryFeature");
const TestFeature_1 = require("./feature/test/TestFeature");
const TimeoutFeature_1 = require("./feature/timeout/TimeoutFeature");
const FEATURE_CLASS = {
    ratelimit: RatelimitFeature_1.RatelimitFeature,
    retry: RetryFeature_1.RetryFeature,
    test: TestFeature_1.TestFeature,
    timeout: TimeoutFeature_1.TimeoutFeature,
};
const FEATURE_PLUGINS = {};
exports.FEATURE_PLUGINS = FEATURE_PLUGINS;
class Config {
    makeFeature(fn) {
        const fc = FEATURE_CLASS[fn];
        const fi = new fc();
        return fi;
    }
    // False for a feature added at runtime via options.extend (station's
    // adopt path) - the constructor uses this to skip makeFeature for names
    // no generated class backs.
    hasFeature(fn) {
        return null != FEATURE_CLASS[fn];
    }
    main = {
        name: 'BitcoinBarometer',
        slug: "bitcoin-barometer",
        version: "0.0.1",
        target: "ts",
    };
    feature = {
        ratelimit: {
            "options": {
                "active": false,
                "burst": 5,
                "rate": 5
            },
            "optspec": {
                "now": "`$FUNCTION`",
                "sleep": "`$FUNCTION`"
            },
            "strict": false,
            "transport": "wrap"
        },
        retry: {
            "options": {
                "active": false,
                "factor": 2,
                "maxDelay": 2000,
                "minDelay": 50,
                "retries": 2,
                "statuses": [
                    408,
                    425,
                    429,
                    500,
                    502,
                    503,
                    504
                ]
            },
            "optspec": {
                "jitter": "`$BOOLEAN`",
                "sleep": "`$FUNCTION`"
            },
            "strict": false,
            "transport": "wrap"
        },
        test: {
            "options": {
                "active": false
            },
            "optspec": {
                "entity": "`$MAP`",
                "net": "`$MAP`"
            },
            "strict": false,
            "transport": "base"
        },
        timeout: {
            "options": {
                "active": false,
                "ms": 30000
            },
            "optspec": {
                "clearTimer": "`$FUNCTION`",
                "now": "`$FUNCTION`",
                "setTimer": "`$FUNCTION`"
            },
            "strict": false,
            "transport": "wrap"
        },
    };
    options = {
        base: "https://nakamotonotes.com/open",
        headers: {
            "content-type": "application/json"
        },
        entity: {
            badge: {},
            barometer: {},
        }
    };
    entity = {
        "badge": {
            "fields": [
                {
                    "name": "color",
                    "title": "Color",
                    "type": "`$STRING`",
                    "short": "Badge colour name."
                },
                {
                    "name": "label",
                    "title": "Label",
                    "type": "`$STRING`",
                    "req": true,
                    "short": "Badge label."
                },
                {
                    "name": "message",
                    "title": "Message",
                    "type": "`$STRING`",
                    "req": true,
                    "short": "Badge message, e.g."
                },
                {
                    "name": "schemaVersion",
                    "title": "Schema Version",
                    "type": "`$INTEGER`",
                    "req": true,
                    "short": "Shields endpoint schema version (1)."
                }
            ],
            "name": "badge",
            "op": {
                "load": {
                    "input": "data",
                    "name": "load",
                    "points": [
                        {
                            "kind": "http",
                            "method": "GET",
                            "orig": "/badge.json",
                            "segments": [
                                {
                                    "lit": "badge.json"
                                }
                            ],
                            "parts": [
                                "badge.json"
                            ],
                            "rename": {},
                            "transform": {
                                "req": "`reqdata`",
                                "res": "`body`"
                            },
                            "args": {},
                            "select": {},
                            "response": {
                                "kind": "json",
                                "media": "application/json"
                            }
                        }
                    ]
                }
            },
            "relations": {
                "ancestors": []
            }
        },
        "barometer": {
            "fields": [
                {
                    "name": "max",
                    "title": "Max",
                    "type": "`$INTEGER`",
                    "short": "Highest score in the zone."
                },
                {
                    "name": "min",
                    "title": "Min",
                    "type": "`$INTEGER`",
                    "short": "Lowest score in the zone."
                },
                {
                    "name": "zone",
                    "title": "Zone",
                    "type": "`$STRING`",
                    "short": "Zone name."
                }
            ],
            "name": "barometer",
            "op": {
                "list": {
                    "input": "data",
                    "name": "list",
                    "points": [
                        {
                            "kind": "http",
                            "method": "GET",
                            "orig": "/barometer.json",
                            "segments": [
                                {
                                    "lit": "barometer.json"
                                }
                            ],
                            "parts": [
                                "barometer.json"
                            ],
                            "rename": {},
                            "transform": {
                                "req": "`reqdata`",
                                "res": "`body`"
                            },
                            "args": {},
                            "select": {},
                            "response": {
                                "kind": "json",
                                "media": "application/json"
                            }
                        }
                    ]
                }
            },
            "relations": {
                "ancestors": []
            }
        }
    };
}
const config = new Config();
exports.config = config;
//# sourceMappingURL=Config.js.map