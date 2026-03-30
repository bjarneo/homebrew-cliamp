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
  version "1.31.3"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.31.3/cliamp-darwin-arm64"
      sha256 "761ea787965fb30905a9d2042f4623ea9aa5344da6f3798522e75ca29234f8cd"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.31.3/cliamp-darwin-amd64"
      sha256 "e2b65614c8112a26378e6aea7d515722b0ab8db1eedda9f265843402b055fc34"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.31.3/cliamp-linux-arm64"
      sha256 "f4472efc8daf51be1706753f948ba72ecab7df5d3e8b2b42890415f517467a12"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.31.3/cliamp-linux-amd64"
      sha256 "9c9579ab4b9e1941c5f8abcaa52022856baeb85347f2770b9d0e50180b5ceb65"
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
