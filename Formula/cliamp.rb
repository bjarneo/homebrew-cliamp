class Cliamp < Formula
  desc "A retro terminal music player inspired by Winamp 2.x"
  homepage "https://github.com/bjarneo/cliamp"

  depends_on "ffmpeg" => :recommended
  depends_on "yt-dlp" => :recommended
  version "1.15.0"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.15.0/cliamp-darwin-arm64"
      sha256 "a89ae92adf7a72a41282cdb8ef7030acc9a25b7c81f6517492a61d939d423c6b"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.15.0/cliamp-darwin-amd64"
      sha256 "c5293b3e2cc5658db42b7c2347cc5cfcdc1561ff067dffda9bd57df8d216d51c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.15.0/cliamp-linux-arm64"
      sha256 "b2b2c098b510bae82ff7c315eec9bd0f772708f1250d8b573b695ddef1764e5c"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.15.0/cliamp-linux-amd64"
      sha256 "f786fdabbf534a81bf38f36e4dd9f4e6019f01f3c759e0f6a6469613d2f58de9"
    end
  end

  def install
    binary = Dir["cliamp-*"].first
    bin.install binary => "cliamp"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cliamp --version")
  end
end
