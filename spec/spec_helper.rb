require 'rspec'
require 'rspec/its'
require 'simplecov'
require 'pianobar_notify'
require "codeclimate-test-reporter"

CodeClimate::TestReporter.start

SimpleCov.start do
  add_filter "vendor/bundler_gems" # Ignore gems
  add_filter "spec"
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.disable_monkey_patching!
  config.warnings = false
  config.default_formatter = 'doc' if config.files_to_run.one?
  config.profile_examples = 10
  config.order = :random
  Kernel.srand config.seed
end
