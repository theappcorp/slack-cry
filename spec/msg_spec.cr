require "spec"
require "../src/slackcry"

describe SlackCry::Msg do
  before_each do
    ENV["SLACKCRY_SLACK_BOT_TOKEN"] = "dummy-token"
  end

  it "raises when token is missing" do
    ENV.delete("SLACKCRY_SLACK_BOT_TOKEN")
    expect_raises(Exception, /Missing SLACKCRY_SLACK_BOT_TOKEN/) do
      SlackCry::Msg.send_by_id("C123", "hello")
    end
  end

  it "sends with send_by_id using mock" do
    called = false

    fake_post = ->(url : String, headers : HTTP::Headers, body : String) : HTTP::Client::Response {
      called = true
      url.should eq "https://slack.com/api/chat.postMessage"
      headers["Authorization"]?.should eq "Bearer dummy-token"
      headers["Content-Type"]?.should eq "application/json"
      body.should contain("C123")
      body.should contain("hello from id")
      HTTP::Client::Response.new(200, headers: HTTP::Headers.new, body: %({"ok": true}))
    }

    SlackCry::Msg.send_by_id("C123", "hello from id", fake_post)
    called.should be_true
  end

  it "sends with send_by_name using configured mapping" do
    SlackCry.configure do |config|
      config.channels = { "team" => "C999" }
    end

    called = false
    fake_post = ->(url : String, headers : HTTP::Headers, body : String) : HTTP::Client::Response {
      called = true
      body.should contain("C999")
      body.should contain("hi by name")
      HTTP::Client::Response.new(200, headers: HTTP::Headers.new, body: %({"ok": true}))
    }

    SlackCry::Msg.send_by_name("team", "hi by name", fake_post)
    called.should be_true
  end

  it "raises if unknown channel name is used" do
    SlackCry.configure do |config|
      config.channels = { "ops" => "C000" }
    end

    expect_raises(Exception, /No channel ID mapped for name/) do
      SlackCry::Msg.send_by_name("ghost", "won't send")
    end
  end
end
