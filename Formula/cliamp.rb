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
  version "1.34.1"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.34.1/cliamp-darwin-arm64"
      sha256 "4c036733558e7d8756a7a4411981db43b3f9568824d356d23c8ad6d35146540a"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.34.1/cliamp-darwin-amd64"
      sha256 "b6a47167fc1162b11593af08c333cdc4b1d6ec7ac41364a1eadf2d796cfe7c66"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.34.1/cliamp-linux-arm64"
      sha256 "dd1295ab61f298977c36ec5d52582daa9e527eac563afb2cfd23fc55bcec05ca"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.34.1/cliamp-linux-amd64"
      sha256 "fcf8591c4c74ba58cb4355dd942763973f1b6161a0fa28c7f4fdbcea4e63d274"
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
