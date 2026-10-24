-- BitcoinBarometer SDK configuration

-- Build a fresh, fully materialised config table. Every call rebuilds the
-- whole structure, so prefer require("config_shared") unless you need a
-- private copy you intend to mutate.
local function make_config()
  return {
    main = {
      name = "BitcoinBarometer",
      slug = "bitcoin-barometer",
      version = "0.0.1",
      target = "lua",
    },
    feature = {
      ["ratelimit"] = {
        ["options"] = {
          ["active"] = false,
          ["burst"] = 5,
          ["rate"] = 5,
        },
        ["optspec"] = {
          ["now"] = "`$FUNCTION`",
          ["sleep"] = "`$FUNCTION`",
        },
        ["strict"] = false,
        ["transport"] = "wrap",
      },
      ["retry"] = {
        ["options"] = {
          ["active"] = false,
          ["factor"] = 2,
          ["maxDelay"] = 2000,
          ["minDelay"] = 50,
          ["retries"] = 2,
          ["statuses"] = {
            408,
            425,
            429,
            500,
            502,
            503,
            504,
          },
        },
        ["optspec"] = {
          ["jitter"] = "`$BOOLEAN`",
          ["sleep"] = "`$FUNCTION`",
        },
        ["strict"] = false,
        ["transport"] = "wrap",
      },
      ["test"] = {
        ["options"] = {
          ["active"] = false,
        },
        ["optspec"] = {
          ["entity"] = "`$MAP`",
          ["net"] = "`$MAP`",
        },
        ["strict"] = false,
        ["transport"] = "base",
      },
      ["timeout"] = {
        ["options"] = {
          ["active"] = false,
          ["ms"] = 30000,
        },
        ["optspec"] = {
          ["clearTimer"] = "`$FUNCTION`",
          ["now"] = "`$FUNCTION`",
          ["setTimer"] = "`$FUNCTION`",
        },
        ["strict"] = false,
        ["transport"] = "wrap",
      },
    },
    options = {
      base = "https://nakamotonotes.com/open",
      headers = {
        ["content-type"] = "application/json",
      },
      entity = {
        ["badge"] = {},
        ["barometer"] = {},
      },
    },
    entity = {
      ["badge"] = {
        ["fields"] = {
          {
            ["name"] = "color",
            ["title"] = "Color",
            ["type"] = "`$STRING`",
            ["short"] = "Badge colour name.",
          },
          {
            ["name"] = "label",
            ["title"] = "Label",
            ["type"] = "`$STRING`",
            ["req"] = true,
            ["short"] = "Badge label.",
          },
          {
            ["name"] = "message",
            ["title"] = "Message",
            ["type"] = "`$STRING`",
            ["req"] = true,
            ["short"] = "Badge message, e.g.",
          },
          {
            ["name"] = "schemaVersion",
            ["title"] = "Schema Version",
            ["type"] = "`$INTEGER`",
            ["req"] = true,
            ["short"] = "Shields endpoint schema version (1).",
          },
        },
        ["name"] = "badge",
        ["op"] = {
          ["load"] = {
            ["input"] = "data",
            ["name"] = "load",
            ["points"] = {
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/badge.json",
                ["segments"] = {
                  {
                    ["lit"] = "badge.json",
                  },
                },
                ["parts"] = {
                  "badge.json",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
                ["args"] = {},
                ["select"] = {},
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
            },
          },
        },
        ["relations"] = {
          ["ancestors"] = {},
        },
      },
      ["barometer"] = {
        ["fields"] = {
          {
            ["name"] = "max",
            ["title"] = "Max",
            ["type"] = "`$INTEGER`",
            ["short"] = "Highest score in the zone.",
          },
          {
            ["name"] = "min",
            ["title"] = "Min",
            ["type"] = "`$INTEGER`",
            ["short"] = "Lowest score in the zone.",
          },
          {
            ["name"] = "zone",
            ["title"] = "Zone",
            ["type"] = "`$STRING`",
            ["short"] = "Zone name.",
          },
        },
        ["name"] = "barometer",
        ["op"] = {
          ["list"] = {
            ["input"] = "data",
            ["name"] = "list",
            ["points"] = {
              {
                ["kind"] = "http",
                ["method"] = "GET",
                ["orig"] = "/barometer.json",
                ["segments"] = {
                  {
                    ["lit"] = "barometer.json",
                  },
                },
                ["parts"] = {
                  "barometer.json",
                },
                ["rename"] = {},
                ["transform"] = {
                  ["req"] = "`reqdata`",
                  ["res"] = "`body`",
                },
                ["args"] = {},
                ["select"] = {},
                ["response"] = {
                  ["kind"] = "json",
                  ["media"] = "application/json",
                },
              },
            },
          },
        },
        ["relations"] = {
          ["ancestors"] = {},
        },
      },
    },
  }
end


local function make_feature(name)
  local features = require("features")
  local factory = features[name]
  if factory ~= nil then
    return factory()
  end
  return features.base()
end


-- Attach make_feature to the SDK class
local function setup_sdk(SDK)
  SDK._make_feature = make_feature
end


return make_config
