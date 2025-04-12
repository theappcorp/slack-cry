require "spec"
require "../src/slackcry"

describe SlackCry::JSONHelpers do
  it "returns the error string if present" do
    json = JSON.parse(%({"error": "invalid_auth"}))
    SlackCry::JSONHelpers.extract_error(json).should eq "invalid_auth"
  end

  it "returns 'Unknown error' if error key is missing" do
    json = JSON.parse(%({"message": "fail"}))
    SlackCry::JSONHelpers.extract_error(json).should eq "Unknown error"
  end

  it "returns 'Unknown error' if error is null" do
    json = JSON.parse(%({"error": null}))
    SlackCry::JSONHelpers.extract_error(json).should eq "Unknown error"
  end

  it "returns 'Unknown error' if error is not a string" do
    json = JSON.parse(%({"error": 123}))
    SlackCry::JSONHelpers.extract_error(json).should eq "Unknown error"
  end
end
