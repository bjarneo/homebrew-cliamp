class Cliamp < Formula
  desc "A retro terminal music player inspired by Winamp 2.x"
  homepage "https://github.com/bjarneo/cliamp"

  head "https://github.com/bjarneo/cliamp.git", branch: "main"

  depends_on "flac"
  depends_on "libvorbis"
  depends_on "libogg"
  depends_on "ffmpeg" => :recommended
  depends_on "yt-dlp" => :recommended
  depends_on "go" => :build
  version "1.39.0"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.39.0/cliamp-darwin-arm64"
      sha256 "97dbbecd0bff86fe71f7a402480c2018f810b9f9f9033776ca7c76c595167e86"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.39.0/cliamp-darwin-amd64"
      sha256 "362e423b90261d08d7755f4c1b3324a352234845375fe355ffe895e608311acb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.39.0/cliamp-linux-arm64"
      sha256 "60d27d3ffe55494fabb5d6097971696d0a56a9bf502fe1ba76a2551ee1c25bc1"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.39.0/cliamp-linux-amd64"
      sha256 "e0592547aeac3a4a552a2db1aa6f0ba6df18f4f51372edef833939e7e5dcd572"
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
