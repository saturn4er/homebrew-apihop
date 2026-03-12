class Apihop < Formula
  desc "Fast, open-source API client for REST, GraphQL, and WebSocket"
  homepage "https://github.com/saturn4er/apihop"
  version "0.1.0"
  license "MIT"

  if build.head?
    head "https://github.com/saturn4er/apihop.git", branch: "master"
  elsif build.bottle? || !build.build_from_source?
    # Prebuilt binaries
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
  else
    url "https://github.com/saturn4er/apihop/archive/refs/tags/v#{version}.tar.gz"
    sha256 "PLACEHOLDER"
  end

  depends_on "rust" => :build
  depends_on "node" => :build

  def install
    if Dir.glob("apihop-server-*").any?
      # Prebuilt binary
      bin.install Dir.glob("apihop-server-*").first => "apihop"
    else
      # Build from source
      system "npm", "install", "-g", "bun"
      cd "ui" do
        system "bun", "install"
        system "bun", "run", "build"
      end
      system "cargo", "build", "--release", "-p", "apihop-server"
      bin.install "target/release/apihop-server" => "apihop"
    end
  end

  test do
    assert_match "apihop", shell_output("#{bin}/apihop --help 2>&1", 1)
  end
end
