class Cliamp < Formula
  desc "A retro terminal music player inspired by Winamp 2.x"
  homepage "https://github.com/bjarneo/cliamp"

  head "https://github.com/bjarneo/cliamp.git", branch: "main"

  depends_on "ffmpeg" => :recommended
  depends_on "yt-dlp" => :recommended
  depends_on "go" => :build
  version "1.17.12"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.17.12/cliamp-darwin-arm64"
      sha256 "992b2c3e80e755c669a838fca0d8bd2f4f271b393bb0fa1b05c412e8705dc84a"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.17.12/cliamp-darwin-amd64"
      sha256 "cf8e72a2e75c001f0601964643bf28af47f8001913f8911fcf92a582a33ee342"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.17.12/cliamp-linux-arm64"
      sha256 "3cd6de1a9ede22306886926d0c89b1a865dc2f2d50a03f9ec2de952becf804cb"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.17.12/cliamp-linux-amd64"
      sha256 "8cdf6d01f533d2b5f508ae93d74c45d8fd9cbeaefd8d41c3102d565b9331e5cc"
    end
  end

  def install
    if build.head?
      # Build from source for HEAD
      system "go", "build", "-ldflags", "-s -w", "-o", bin/"cliamp", "."
    else
      # Use pre-built binary for stable releases
      binary = Dir["cliamp-*"].first
      bin.install binary => "cliamp"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cliamp --version")
  end
end
