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
  version "1.27.4"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.27.4/cliamp-darwin-arm64"
      sha256 "ba3aecc9d21cbbd1dba4324891301d628e31e36a13c7aea74b5b1cb4bad0a625"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.27.4/cliamp-darwin-amd64"
      sha256 "42390782c4383b15aa2614a502ca74ee52c2627c7ab0f2b0045379b502fd0aa0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.27.4/cliamp-linux-arm64"
      sha256 "38eac6fca2614b57736f0617e6b4592a019ffa10588ee65cb432e484bc09ba1a"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.27.4/cliamp-linux-amd64"
      sha256 "be0c726a9665d19beb050a0ab6ee23387ef43ef67ffcfd21b3f6e12fa9667cdf"
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
