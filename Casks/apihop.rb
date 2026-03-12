cask "apihop" do
  version "0.0.1"

  on_arm do
    url "https://github.com/saturn4er/apihop/releases/download/v#{version}/apihop_#{version}_aarch64.dmg"
    sha256 "PLACEHOLDER"
  end

  on_intel do
    url "https://github.com/saturn4er/apihop/releases/download/v#{version}/apihop_#{version}_x64.dmg"
    sha256 "PLACEHOLDER"
  end

  name "apihop"
  desc "Fast, open-source API client for REST, GraphQL, and WebSocket"
  homepage "https://github.com/saturn4er/apihop"

  app "apihop.app"

  zap trash: [
    "~/Library/Application Support/com.apihop.app",
    "~/Library/Caches/com.apihop.app",
    "~/Library/Preferences/com.apihop.app.plist",
    "~/Library/Saved Application State/com.apihop.app.savedState",
  ]
end
