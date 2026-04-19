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
  version "1.37.1"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.37.1/cliamp-darwin-arm64"
      sha256 "3f22612cc15d88d37bdf67be39081356431dd01a463f72a55151407797e25557"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.37.1/cliamp-darwin-amd64"
      sha256 "543c59f8901c595732ee071b56c738f5e9b4ae3bb5137fb1db185ea6f328faed"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.37.1/cliamp-linux-arm64"
      sha256 "b52d2b4845d627b8d6e44dc9bddfe0570765dce4a59158c30b8c0297fdedc690"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.37.1/cliamp-linux-amd64"
      sha256 "ea469897182dbe554590380dd0fa4f1b5bfe5fb363fd79b68eeaab7430167d2c"
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
