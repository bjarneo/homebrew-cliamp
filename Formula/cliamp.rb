class Cliamp < Formula
  desc "A retro terminal music player inspired by Winamp 2.x"
  homepage "https://github.com/bjarneo/cliamp"

  depends_on "ffmpeg" => :recommended
  depends_on "yt-dlp" => :recommended
  version "1.12.8"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.12.8/cliamp-darwin-arm64"
      sha256 "837d51f82e61b1fe30a2182d82695d0e491b32398dfbc18fcfb08723f4fb54bd"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.12.8/cliamp-darwin-amd64"
      sha256 "a2ee82cc2cfc7dff06ed763d65b3013f93804d834fdedcd228c3012c283cc603"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.12.8/cliamp-linux-arm64"
      sha256 "0c429ca31de1000b18793e969cf8069f42f0178ab437e04855c9d44df24a4652"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.12.8/cliamp-linux-amd64"
      sha256 "ce5cb235fa7d3f7a899e4b00971ad68b6e0470080c0f32a40b1389c2d9ca95f2"
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
