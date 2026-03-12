class Apihop < Formula
  desc "Fast, open-source API client for REST, GraphQL, and WebSocket"
  homepage "https://github.com/saturn4er/apihop"
  url "https://github.com/saturn4er/apihop/archive/refs/tags/v0.0.1.tar.gz"
  sha256 "cdadaf2876f55b7397167e67ffe7b1b4005936f696286df8ab10339e3f9422bc"
  license "MIT"
  head "https://github.com/saturn4er/apihop.git", branch: "master"

  depends_on "rust" => :build
  depends_on "node" => :build

  def install
    cd "ui" do
      system "npm", "install"
      system "npm", "run", "build"
    end
    system "cargo", "build", "--release", "-p", "apihop-server"
    bin.install "target/release/apihop-server" => "apihop"
  end

  test do
    assert_match "apihop", shell_output("#{bin}/apihop --help 2>&1", 1)
  end
end
