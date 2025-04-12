require "../src/slackcry"

def prompt(label : String) : String
  print "#{label}: "
  gets.to_s.strip
end

channel_id = prompt("💬 Channel ID")
message    = prompt("✍️  Message text")
token      = prompt("🔑 SLACK_BOT_TOKEN")

ENV["SLACKCRY_SLACK_BOT_TOKEN"] = token

puts "\n📤 Sending message..."
response = SlackCry::Msg.send_by_id(channel_id, message)

puts "\n📦 HTTP Status: #{response.status_code}"
puts "📨 Raw Body:"

parsed = JSON.parse(response.body)
puts parsed.to_pretty_json

if parsed["ok"] == true
  puts "\n✅ Message sent successfully to Slack!"
else
  error_msg = parsed["error"]?.try(&.as_s?) || "Unknown error"
  puts "\n❌ Failed to send message: #{SlackCry::JSONHelpers.extract_error(parsed)}"
end
