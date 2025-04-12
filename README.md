```
...........................................................................................
......::::::::..:::............:::......::::::::..:::....:::.::::::::..:::::::::..:::...:::
....:+:....:+:.:+:..........:+:.:+:...:+:....:+:.:+:...:+:.:+:....:+:.:+:....:+:.:+:...:+:.
...+:+........+:+.........+:+...+:+..+:+........+:+..+:+..+:+........+:+....+:+..+:+.+:+...
..+#++:++#++.+#+........+#++:++#++:.+#+........+#++:++...+#+........+#++:++#:....+#++:.....
........+#+.+#+........+#+.....+#+.+#+........+#+..+#+..+#+........+#+....+#+....+#+.......
#+#....#+#.#+#........#+#.....#+#.#+#....#+#.#+#...#+#.#+#....#+#.#+#....#+#....#+#........
########..##########.###.....###..########..###....###.########..###....###....###.........
...........................................................................................
```

# SlackCry

Send messages to Slack channels using simple, testable Crystal code — no fuss, no complex clients.\
Supports named channel registration for easy multi-channel messaging.

---

## Features

- Send Slack messages by channel **ID** or **name**
- Configure named channels for readable, maintainable code
- Inject HTTP clients for easy mocking in tests
- Built-in error extraction and test coverage support

---

## Installation

Add to your `shard.yml`:

```yaml
dependencies:
  slackcry:
    github: theappcorp/slackcry
    version: ~> 1.0.0
```

Then run:

```bash
shards install
```

> Requires Crystal `>= 1.0`.

---

## Slack App Setup

To use SlackCry, you'll need a Slack app with the proper permissions and a bot token.

1. Go to [https://api.slack.com/apps](https://api.slack.com/apps)
2. Create a new app (from scratch or manifest)
3. Enable **OAuth & Permissions**
4. Under **Scopes**, add:
   - `chat:write` (to send messages)
   - `channels:read` (optional, to read channel info)
5. Install the app to your Slack workspace
6. **Invite the bot user to any channel it should message**:
   ```bash
   /invite @your-bot-name
   ```
7. Copy the **Bot User OAuth Token** (starts with `xoxb-...`)
8. Set it in your environment:

```bash
export SLACKCRY_SLACK_BOT_TOKEN="xoxb-your-token"
```

---

## Setup

Configure named channels:

```crystal
SlackCry.configure do |config|
  config.channels = {
    "dev"     => "C1234567890",
    "alerts"  => "C2345678901",
    "support" => "C3456789012"
  }
end
```

---

## Usage

### Send to a channel by ID

```crystal
SlackCry::Msg.send_by_id("C1234567890", "Hello from SlackCry")
```

### Send to a channel by name

```crystal
SlackCry::Msg.send_by_name("alerts", "Deployment complete.")
```

---

## Running Tests

```bash
crystal spec
```

To generate coverage:

```bash
COVERAGE=1 crystal spec
shards run coverage
open coverage/index.html
```

---

## Contributing

### Want to help?

We're looking for help wiring up:

- CI workflow with GitHub Actions
- Coverage threshold enforcement
- Ameba linting support on PRs

### Dev Setup

```bash
sudo apt install make
shards install
```

### Suggested Improvements

- Email suggestions/feature requests

---

## Open a PR

If you're down to help enforce code quality:

1. Fork the repo
2. Create a new branch
3. Add `ameba.yml` + `.github/workflows/lint.yml`
4. Send it!

We're small, fast, and merge fast. Bonus points for 100% test coverage and clean commits.

---

## Contact

Questions, ideas, or feedback?

🌐 Visit us on the web: [www.appcorp.com](https://appcorp.com)

📬 Email us at: [developers@appcorp.com](mailto:developers@appcorp.com)

We're a small team that cares about clean tools and fast iterations.

---

## License

MIT License

© 2025 AppCorp® - The Application Corporation™

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the “Software”), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

