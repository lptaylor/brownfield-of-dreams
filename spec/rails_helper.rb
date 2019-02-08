require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'vcr'
require 'webmock/rspec'
require 'omniauth-github'
require 'capybara/email/rspec'

VCR.configure do |config|
  config.ignore_localhost = true
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.allow_http_connections_when_no_cassette = true
  config.filter_sensitive_data("<YOUTUBE_API_KEY>") { ENV['YOUTUBE_API_KEY'] }
end

OmniAuth.config.test_mode = true

ActiveRecord::Migration.maintain_test_schema!

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.javascript_driver = :selenium_chrome

Capybara.configure do |config|
  config.default_max_wait_time = 5
end

SimpleCov.start "rails"

Shoulda::Matchers.configure do |config|
    config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.include FactoryBot::Syntax::Methods

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end

def stub_omniauth_github
  OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
    :'uid' => 123545,
    :'credentials' => {:'token' => 'dfafeaf3432q45432454'},
    :extra => {:'raw_info' => {:'login' => 'lptaylor'}}
    })
end

def get_repos
  stub_request(:any, "https://api.github.com/user/repos").
     with(headers: { 'Authorization' => "token abc"}).
   to_return(body: File.read("./spec/fixtures/repos_mock_api.json"))
end

def get_followers
  stub_request(:any, "https://api.github.com/user/followers").
     with(headers: { 'Authorization' => "token abc"}).
   to_return(body: File.read("./spec/fixtures/followers_mock_api.json"))
end

def get_following
  stub_request(:any, "https://api.github.com/user/following").
     with(headers: { 'Authorization' => "token abc"}).
   to_return(body: File.read("./spec/fixtures/following_mock_api.json"))
end
