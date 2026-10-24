<?php
declare(strict_types=1);

// BitcoinBarometer SDK configuration

class BitcoinBarometerConfig
{
    /** @var array<string,mixed>|null */
    private static ?array $shared_config = null;

    /**
     * Return the process-wide config, built once on first use. The SDK reads
     * the config on every request and never writes to it, so one instance is
     * shared by every client rather than rebuilt per client.
     *
     * PHP arrays are copy-on-write, so callers that do mutate the result get
     * their own copy and cannot disturb the shared one.
     */
    public static function shared_config(): array
    {
        if (self::$shared_config === null) {
            self::$shared_config = self::make_config();
        }
        return self::$shared_config;
    }

    /**
     * Build a fresh, fully materialised config array. Every call rebuilds the
     * whole structure, so prefer shared_config unless you need a private copy.
     */
    public static function make_config(): array
    {
        return [
            "main" => [
                "name" => "BitcoinBarometer",
                "slug" => "bitcoin-barometer",
                "version" => "0.0.1",
                "target" => "php",
            ],
            "feature" => [
                "ratelimit" => [
          'options' => [
            'active' => false,
            'burst' => 5,
            'rate' => 5,
          ],
          'optspec' => [
            'now' => '`$FUNCTION`',
            'sleep' => '`$FUNCTION`',
          ],
          'strict' => false,
          'transport' => 'wrap',
        ],
                "retry" => [
          'options' => [
            'active' => false,
            'factor' => 2,
            'maxDelay' => 2000,
            'minDelay' => 50,
            'retries' => 2,
            'statuses' => [
              408,
              425,
              429,
              500,
              502,
              503,
              504,
            ],
          ],
          'optspec' => [
            'jitter' => '`$BOOLEAN`',
            'sleep' => '`$FUNCTION`',
          ],
          'strict' => false,
          'transport' => 'wrap',
        ],
                "test" => [
          'options' => [
            'active' => false,
          ],
          'optspec' => [
            'entity' => '`$MAP`',
            'net' => '`$MAP`',
          ],
          'strict' => false,
          'transport' => 'base',
        ],
                "timeout" => [
          'options' => [
            'active' => false,
            'ms' => 30000,
          ],
          'optspec' => [
            'clearTimer' => '`$FUNCTION`',
            'now' => '`$FUNCTION`',
            'setTimer' => '`$FUNCTION`',
          ],
          'strict' => false,
          'transport' => 'wrap',
        ],
            ],
            "options" => [
                "base" => "https://nakamotonotes.com/open",
                "headers" => [
          'content-type' => 'application/json',
        ],
                "entity" => [
                    "badge" => [],
                    "barometer" => [],
                ],
            ],
            "entity" => [
        'badge' => [
          'fields' => [
            [
              'name' => 'color',
              'title' => 'Color',
              'type' => '`$STRING`',
              'short' => 'Badge colour name.',
            ],
            [
              'name' => 'label',
              'title' => 'Label',
              'type' => '`$STRING`',
              'req' => true,
              'short' => 'Badge label.',
            ],
            [
              'name' => 'message',
              'title' => 'Message',
              'type' => '`$STRING`',
              'req' => true,
              'short' => 'Badge message, e.g.',
            ],
            [
              'name' => 'schemaVersion',
              'title' => 'Schema Version',
              'type' => '`$INTEGER`',
              'req' => true,
              'short' => 'Shields endpoint schema version (1).',
            ],
          ],
          'name' => 'badge',
          'op' => [
            'load' => [
              'input' => 'data',
              'name' => 'load',
              'points' => [
                [
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/badge.json',
                  'segments' => [
                    [
                      'lit' => 'badge.json',
                    ],
                  ],
                  'parts' => [
                    'badge.json',
                  ],
                  'rename' => [],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                  'args' => [],
                  'select' => [],
                  'response' => [
                    'kind' => 'json',
                    'media' => 'application/json',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [],
          ],
        ],
        'barometer' => [
          'fields' => [
            [
              'name' => 'max',
              'title' => 'Max',
              'type' => '`$INTEGER`',
              'short' => 'Highest score in the zone.',
            ],
            [
              'name' => 'min',
              'title' => 'Min',
              'type' => '`$INTEGER`',
              'short' => 'Lowest score in the zone.',
            ],
            [
              'name' => 'zone',
              'title' => 'Zone',
              'type' => '`$STRING`',
              'short' => 'Zone name.',
            ],
          ],
          'name' => 'barometer',
          'op' => [
            'list' => [
              'input' => 'data',
              'name' => 'list',
              'points' => [
                [
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/barometer.json',
                  'segments' => [
                    [
                      'lit' => 'barometer.json',
                    ],
                  ],
                  'parts' => [
                    'barometer.json',
                  ],
                  'rename' => [],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                  'args' => [],
                  'select' => [],
                  'response' => [
                    'kind' => 'json',
                    'media' => 'application/json',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [],
          ],
        ],
      ],
        ];
    }


    public static function make_feature(string $name)
    {
        require_once __DIR__ . '/features.php';
        return BitcoinBarometerFeatures::make_feature($name);
    }
}
