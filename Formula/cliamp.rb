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
  version "1.33.4"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.33.4/cliamp-darwin-arm64"
      sha256 "9cbda21efe5088c5e5ca3af65f221bb420cbba3ae22b58d01dbdfe887e3ada25"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.33.4/cliamp-darwin-amd64"
      sha256 "5a64e56efed04d03aca46731a9d2216d98687ab32ea5311a50fcd98d4a595c62"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.33.4/cliamp-linux-arm64"
      sha256 "7bb38c8daa7985ed016a73c3eec57025d7ea77e78bc50061985341f24c3d5431"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.33.4/cliamp-linux-amd64"
      sha256 "a84e364a07dfff368da0ef88c165ca2d2c41835e3da4b658562672deae01cee8"
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
