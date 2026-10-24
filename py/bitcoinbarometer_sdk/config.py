# BitcoinBarometer SDK configuration


# The sekreto plugin DEFINITIONS the model selected per feature, imported
# above by name from the modules the catalogue's active `plugin.def`
# entries declare. Handed to each feature (secrets builds its Sekreto
# with them): a provider kind not listed here is unknown to that SDK.
FEATURE_PLUGINS = {
}


_shared_config = None


def shared_config():
    """Return the process-wide config, built once on first use.

    The SDK reads the config on every request and never writes to it, so one
    instance is shared by every client rather than rebuilt per client.

    The returned dict is shared: treat it as read-only. Callers that need to
    mutate should use make_config, which always returns a fresh copy.
    """
    global _shared_config
    if _shared_config is None:
        _shared_config = make_config()
    return _shared_config


def make_config():
    """Build a fresh, fully materialised config dict.

    Every call rebuilds the whole structure, so prefer shared_config unless
    you need a private copy you intend to mutate.
    """
    return {
        "main": {
            "name": "BitcoinBarometer",
            "slug": "bitcoin-barometer",
            "version": "0.0.1",
            "target": "py",
        },
        "feature": {
            "ratelimit": {
        "options": {
          "active": False,
          "burst": 5,
          "rate": 5,
        },
        "optspec": {
          "now": "`$FUNCTION`",
          "sleep": "`$FUNCTION`",
        },
        "strict": False,
        "transport": "wrap",
      },
            "retry": {
        "options": {
          "active": False,
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
            504,
          ],
        },
        "optspec": {
          "jitter": "`$BOOLEAN`",
          "sleep": "`$FUNCTION`",
        },
        "strict": False,
        "transport": "wrap",
      },
            "test": {
        "options": {
          "active": False,
        },
        "optspec": {
          "entity": "`$MAP`",
          "net": "`$MAP`",
        },
        "strict": False,
        "transport": "base",
      },
            "timeout": {
        "options": {
          "active": False,
          "ms": 30000,
        },
        "optspec": {
          "clearTimer": "`$FUNCTION`",
          "now": "`$FUNCTION`",
          "setTimer": "`$FUNCTION`",
        },
        "strict": False,
        "transport": "wrap",
      },
        },
        "options": {
            "base": "https://nakamotonotes.com/open",
            "headers": {
        "content-type": "application/json",
      },
            "entity": {
                "badge": {},
                "barometer": {},
            },
        },
        "entity": {
      "badge": {
        "fields": [
          {
            "name": "color",
            "title": "Color",
            "type": "`$STRING`",
            "short": "Badge colour name.",
          },
          {
            "name": "label",
            "title": "Label",
            "type": "`$STRING`",
            "req": True,
            "short": "Badge label.",
          },
          {
            "name": "message",
            "title": "Message",
            "type": "`$STRING`",
            "req": True,
            "short": "Badge message, e.g.",
          },
          {
            "name": "schemaVersion",
            "title": "Schema Version",
            "type": "`$INTEGER`",
            "req": True,
            "short": "Shields endpoint schema version (1).",
          },
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
                    "lit": "badge.json",
                  },
                ],
                "parts": [
                  "badge.json",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {},
                "select": {},
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
      "barometer": {
        "fields": [
          {
            "name": "max",
            "title": "Max",
            "type": "`$INTEGER`",
            "short": "Highest score in the zone.",
          },
          {
            "name": "min",
            "title": "Min",
            "type": "`$INTEGER`",
            "short": "Lowest score in the zone.",
          },
          {
            "name": "zone",
            "title": "Zone",
            "type": "`$STRING`",
            "short": "Zone name.",
          },
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
                    "lit": "barometer.json",
                  },
                ],
                "parts": [
                  "barometer.json",
                ],
                "rename": {},
                "transform": {
                  "req": "`reqdata`",
                  "res": "`body`",
                },
                "args": {},
                "select": {},
                "response": {
                  "kind": "json",
                  "media": "application/json",
                },
              },
            ],
          },
        },
        "relations": {
          "ancestors": [],
        },
      },
    },
    }
