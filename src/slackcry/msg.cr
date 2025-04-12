require "http/client"
require "json"

module SlackCry
  class Msg
    alias HttpPostProc = Proc(String, HTTP::Headers, String, HTTP::Client::Response)
    DEFAULT_HTTP_POST = ->(url : String, headers : HTTP::Headers, body : String) : HTTP::Client::Response {
      HTTP::Client.post(url, headers: headers, body: body)
    }

    # Public: Send directly using channel ID
    def self.send_by_id(
      channel_id : String,
      text : String,
      http_post : HttpPostProc = DEFAULT_HTTP_POST
    ) : HTTP::Client::Response
      _send(channel_id, text, http_post)
    end

    # Public: Send using a configured channel name
    def self.send_by_name(
      channel_name : String,
      text : String,
      http_post : HttpPostProc = DEFAULT_HTTP_POST
    ) : HTTP::Client::Response
      channel_id = SlackCry.config.channels[channel_name]? ||
                   raise "❌ No channel ID mapped for name: #{channel_name}"
      _send(channel_id, text, http_post)
    end

    private def self._send(
      channel_id : String,
      text : String,
      http_post : HttpPostProc
    ) : HTTP::Client::Response
      token = ENV["SLACKCRY_SLACK_BOT_TOKEN"]? ||
              raise "😬 Missing SLACKCRY_SLACK_BOT_TOKEN"

      body = {
        channel: channel_id,
        text: text
      }.to_json

      http_post.call(
        "https://slack.com/api/chat.postMessage",
        HTTP::Headers{
          "Authorization" => "Bearer #{token}",
          "Content-Type"  => "application/json"
        },
        body
      )
    end
  end
end
