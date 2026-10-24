# BitcoinBarometer SDK configuration

module BitcoinBarometerConfig
  # Return the process-wide config, built once on first use. The SDK reads
  # the config on every request and never writes to it, so one instance is
  # shared by every client rather than rebuilt per client.
  #
  # The returned hash is shared: treat it as read-only. Callers that need to
  # mutate should use make_config, which always returns a fresh copy.
  def self.shared_config
    @shared_config ||= make_config
  end


  # Build a fresh, fully materialised config hash. Every call rebuilds the
  # whole structure, so prefer shared_config unless you need a private copy
  # you intend to mutate.
  def self.make_config
    {
      "main" => {
        "name" => "BitcoinBarometer",
        "slug" => "bitcoin-barometer",
        "version" => "0.0.1",
        "target" => "rb",
      },
      "feature" => {
        "ratelimit" => {
          "options" => {
            "active" => false,
            "burst" => 5,
            "rate" => 5,
          },
          "optspec" => {
            "now" => "`$FUNCTION`",
            "sleep" => "`$FUNCTION`",
          },
          "strict" => false,
          "transport" => "wrap",
        },
        "retry" => {
          "options" => {
            "active" => false,
            "factor" => 2,
            "maxDelay" => 2000,
            "minDelay" => 50,
            "retries" => 2,
            "statuses" => [
              408,
              425,
              429,
              500,
              502,
              503,
              504,
            ],
          },
          "optspec" => {
            "jitter" => "`$BOOLEAN`",
            "sleep" => "`$FUNCTION`",
          },
          "strict" => false,
          "transport" => "wrap",
        },
        "test" => {
          "options" => {
            "active" => false,
          },
          "optspec" => {
            "entity" => "`$MAP`",
            "net" => "`$MAP`",
          },
          "strict" => false,
          "transport" => "base",
        },
        "timeout" => {
          "options" => {
            "active" => false,
            "ms" => 30000,
          },
          "optspec" => {
            "clearTimer" => "`$FUNCTION`",
            "now" => "`$FUNCTION`",
            "setTimer" => "`$FUNCTION`",
          },
          "strict" => false,
          "transport" => "wrap",
        },
      },
      "options" => {
        "base" => "https://nakamotonotes.com/open",
        "headers" => {
          "content-type" => "application/json",
        },
        "entity" => {
          "badge" => {},
          "barometer" => {},
        },
      },
      "entity" => {
        "badge" => {
          "fields" => [
            {
              "name" => "color",
              "title" => "Color",
              "type" => "`$STRING`",
              "short" => "Badge colour name.",
            },
            {
              "name" => "label",
              "title" => "Label",
              "type" => "`$STRING`",
              "req" => true,
              "short" => "Badge label.",
            },
            {
              "name" => "message",
              "title" => "Message",
              "type" => "`$STRING`",
              "req" => true,
              "short" => "Badge message, e.g.",
            },
            {
              "name" => "schemaVersion",
              "title" => "Schema Version",
              "type" => "`$INTEGER`",
              "req" => true,
              "short" => "Shields endpoint schema version (1).",
            },
          ],
          "name" => "badge",
          "op" => {
            "load" => {
              "input" => "data",
              "name" => "load",
              "points" => [
                {
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/badge.json",
                  "segments" => [
                    {
                      "lit" => "badge.json",
                    },
                  ],
                  "parts" => [
                    "badge.json",
                  ],
                  "rename" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "args" => {},
                  "select" => {},
                  "response" => {
                    "kind" => "json",
                    "media" => "application/json",
                  },
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "barometer" => {
          "fields" => [
            {
              "name" => "max",
              "title" => "Max",
              "type" => "`$INTEGER`",
              "short" => "Highest score in the zone.",
            },
            {
              "name" => "min",
              "title" => "Min",
              "type" => "`$INTEGER`",
              "short" => "Lowest score in the zone.",
            },
            {
              "name" => "zone",
              "title" => "Zone",
              "type" => "`$STRING`",
              "short" => "Zone name.",
            },
          ],
          "name" => "barometer",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "kind" => "http",
                  "method" => "GET",
                  "orig" => "/barometer.json",
                  "segments" => [
                    {
                      "lit" => "barometer.json",
                    },
                  ],
                  "parts" => [
                    "barometer.json",
                  ],
                  "rename" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "args" => {},
                  "select" => {},
                  "response" => {
                    "kind" => "json",
                    "media" => "application/json",
                  },
                },
              ],
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
      },
    }
  end


  def self.make_feature(name)
    require_relative 'features'
    BitcoinBarometerFeatures.make_feature(name)
  end
end
