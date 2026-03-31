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
  version "1.31.7"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.31.7/cliamp-darwin-arm64"
      sha256 "dc5666b06c12fa06ec53964851094ba58d9ea96e8d5b580d4725629d590e5618"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.31.7/cliamp-darwin-amd64"
      sha256 "92cbb4ba04b41113b3edacac38ddba39df44770ba51cd5feb9708e75f9332b88"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.31.7/cliamp-linux-arm64"
      sha256 "4c6c5ee229a044b524d111f913e610d1d22ca8e37356c35f518df5a8c8827a98"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.31.7/cliamp-linux-amd64"
      sha256 "477ac10d33f157e97d8ca20f5e1fc60b7946e702cb7e06726326527794efc4c7"
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
