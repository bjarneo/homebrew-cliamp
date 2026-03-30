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
  version "1.31.0"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.31.0/cliamp-darwin-arm64"
      sha256 "087e1779da9824a9a00b49469db54a8359366263dc0281d30478c57169d57995"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.31.0/cliamp-darwin-amd64"
      sha256 "0690252fc11340b7516e5e68db4dbcf4fea990d84fa64c555c2d7321a98644d3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.31.0/cliamp-linux-arm64"
      sha256 "f7b3a0d49e3781964b27a849af2e3a4fbbc286e795e695438a96f1743ca6defd"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.31.0/cliamp-linux-amd64"
      sha256 "a025e79486865414df9bec78313fc3545932cba257d7d962e074d944a2910e1c"
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
