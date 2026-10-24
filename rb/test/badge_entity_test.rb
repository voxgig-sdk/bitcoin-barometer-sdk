# Badge entity test

require "minitest/autorun"
require "json"
require_relative "../BitcoinBarometer_sdk"
require_relative "runner"

class BadgeEntityTest < Minitest::Test
  # main.kit.test.live.strict is true (the default is true): a live
  # request that fails, or a live test missing an input it needs,
  # fails the test.
  # An account with no record for a test to read skips it either way.
  LIVE_STRICT = true

  def test_create_instance
    testsdk = BitcoinBarometerSDK.test(nil, nil)
    ent = testsdk.Badge(nil)
    assert !ent.nil?
  end

  def test_validate
    cfg = BitcoinBarometerConfig.shared_config
    unless cfg["feature"].is_a?(Hash) && cfg["feature"].key?("validate")
      skip("feature not present in this SDK: validate")
    end
    client = BitcoinBarometerSDK.test(nil, { "feature" => { "validate" => { "active" => true } } })
    err = assert_raises(StandardError) do
      client.Badge(nil).load({ "color" => 1 }, nil)
    end
    assert_equal "validate_failed", err.code
  end

  def test_basic_flow
    setup = badge_basic_setup(nil)
    # Per-op sdk-test-control.json skip.
    _live = setup[:live] || false
    ["load"].each do |_op|
      _should_skip, _reason = Runner.is_control_skipped("entityOp", "badge." + _op, _live ? "live" : "unit")
      if _should_skip
        skip(_reason || "skipped via sdk-test-control.json")
        return
      end
    end
    client = setup[:client]

    # Bootstrap entity data from existing test data.
    badge_ref01_data_raw = Vs.items(Helpers.to_map(
      Vs.getpath(setup[:data], "existing.badge")))
    badge_ref01_data = nil
    if badge_ref01_data_raw.length > 0
      badge_ref01_data = Helpers.to_map(badge_ref01_data_raw[0][1])
    end

    # LOAD
    badge_ref01_ent = client.Badge(nil)
    badge_ref01_match_dt0 = {}
    badge_ref01_data_dt0_loaded = badge_ref01_ent.load(badge_ref01_match_dt0, nil)
    assert !badge_ref01_data_dt0_loaded.nil?

  end
end

def badge_basic_setup(extra)
  Runner.load_env_local

  entity_data_file = File.join(__dir__, "..", "..", ".sdk", "test", "entity", "badge", "BadgeTestData.json")
  entity_data_source = File.read(entity_data_file, encoding: "UTF-8")
  entity_data = JSON.parse(entity_data_source)

  options = {}
  options["entity"] = entity_data["existing"]

  client = BitcoinBarometerSDK.test(options, extra)

  # Generate idmap via transform.
  idmap = Vs.transform(
    ["badge01", "badge02", "badge03"],
    {
      "`$PACK`" => ["", {
        "`$KEY`" => "`$COPY`",
        "`$VAL`" => ["`$FORMAT`", "upper", "`$COPY`"],
      }],
    }
  )

  # Whether *_ENTID supplied the idmap, read before env_override consumes
  # it: without it, the ids a live flow binds are the fixture's synthetic ones.
  entid_env_raw = ENV["BITCOIN_BAROMETER_TEST_BADGE_ENTID"]
  idmap_overridden = !entid_env_raw.nil? && entid_env_raw.strip.start_with?("{")

  env = Runner.env_override({
    "BITCOIN_BAROMETER_TEST_BADGE_ENTID" => idmap,
    "BITCOIN_BAROMETER_TEST_LIVE" => "FALSE",
    "BITCOIN_BAROMETER_TEST_EXPLAIN" => "FALSE",
  })

  idmap_resolved = Helpers.to_map(
    env["BITCOIN_BAROMETER_TEST_BADGE_ENTID"])
  if idmap_resolved.nil?
    idmap_resolved = Helpers.to_map(idmap)
  end

  if env["BITCOIN_BAROMETER_TEST_LIVE"] == "TRUE"
    merged_opts = Vs.merge([
      # FIRST, so the generated fields below win: sdk-test-control.json's
      # test.client.options adds to the live client, it does not redirect it.
      Runner.live_client_options,
      {
      },
      extra || {},
    ])
    client = BitcoinBarometerSDK.new(Helpers.to_map(merged_opts))
  end

  live = env["BITCOIN_BAROMETER_TEST_LIVE"] == "TRUE"
  {
    client: client,
    data: entity_data,
    idmap: idmap_resolved,
    env: env,
    explain: env["BITCOIN_BAROMETER_TEST_EXPLAIN"] == "TRUE",
    live: live,
    synthetic_only: live && !idmap_overridden,
    now: (Time.now.to_f * 1000).to_i,
  }
end
