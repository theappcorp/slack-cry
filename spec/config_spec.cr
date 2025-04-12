require "spec"
require "../src/slackcry"

describe SlackCry do
  it "can configure and retrieve channels" do
    SlackCry.configure do |config|
      config.channels = {
        "a" => "C1",
        "b" => "C2"
      }
    end

    SlackCry.config.channels["a"].should eq "C1"
    SlackCry.config.channels["b"].should eq "C2"
  end
end
