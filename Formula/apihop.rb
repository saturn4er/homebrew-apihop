class Apihop < Formula
  desc "Fast, open-source API client for REST, GraphQL, and WebSocket"
  homepage "https://github.com/saturn4er/apihop"
  version "0.0.1"
  license "MIT"

  if build.head?
    head "https://github.com/saturn4er/apihop.git", branch: "master"
  elsif build.bottle? || !build.build_from_source?
    on_macos do
      url "https://github.com/saturn4er/apihop/releases/download/v#{version}/apihop-server-macos-arm64"
      sha256 "d7c2e99be7f847dadab8b16b3b7b318982df49d3ae66c3136b6b1d79e22bbdc3"
    end

    on_linux do
      url "https://github.com/saturn4er/apihop/releases/download/v#{version}/apihop-server-linux-amd64"
      sha256 "d7f80206dacec94a85f2c10f493f0ccf66b2cc8535c6215c506f1d7251a1b34d"
    end
  else
    url "https://github.com/saturn4er/apihop/archive/refs/tags/v#{version}.tar.gz"
    sha256 "PLACEHOLDER"
  end

  depends_on "rust" => :build
  depends_on "node" => :build

  def install
    if Dir.glob("apihop-server-*").any?
      bin.install Dir.glob("apihop-server-*").first => "apihop"
    else
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
