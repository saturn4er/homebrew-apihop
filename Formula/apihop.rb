class Apihop < Formula
  desc "Fast, open-source API client for REST, GraphQL, and WebSocket"
  homepage "https://github.com/saturn4er/apihop"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/saturn4er/apihop/releases/download/v#{version}/apihop-server-macos-arm64"
      sha256 "PLACEHOLDER"
    else
      url "https://github.com/saturn4er/apihop/releases/download/v#{version}/apihop-server-macos-amd64"
      sha256 "PLACEHOLDER"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/saturn4er/apihop/releases/download/v#{version}/apihop-server-linux-arm64"
      sha256 "PLACEHOLDER"
    else
      url "https://github.com/saturn4er/apihop/releases/download/v#{version}/apihop-server-linux-amd64"
      sha256 "PLACEHOLDER"
    end
  end

  def install
    binary = Dir.glob("apihop-server-*").first || "apihop-server"
    bin.install binary => "apihop"
  end

  test do
    assert_match "apihop", shell_output("#{bin}/apihop --help 2>&1", 1)
  end
end
