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
  version "1.21.5"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.21.5/cliamp-darwin-arm64"
      sha256 "8822273dbd51f11ee60d2338bd765a0422e3419fce5b32d33f8ec88489b519c6"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.21.5/cliamp-darwin-amd64"
      sha256 "5dd6b5ed50ebe2aabc46e85bab5c750416f67d0051608f3e71672811ee527f87"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.21.5/cliamp-linux-arm64"
      sha256 "7b6c11389dc545409bb869d35c9ca26e862de20a295555e5aae4b7a337f15dd9"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.21.5/cliamp-linux-amd64"
      sha256 "ad1581947d7f80c8d7da9a2f72fd82946eb80c8f0ce59d47f9834f88b7ea6f98"
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
