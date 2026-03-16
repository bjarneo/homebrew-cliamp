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
  version "1.21.3"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.21.3/cliamp-darwin-arm64"
      sha256 "56dcab219960235cd83f1bf62501ebdc7921530c2ad75c78162fb55f679f202b"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.21.3/cliamp-darwin-amd64"
      sha256 "067d7ffe0e8dafd27015aea07053338416c6c40154d310f4389abeb0616a4e0b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.21.3/cliamp-linux-arm64"
      sha256 "df9cedf1cb029a3a6655053ae367e1e9412826c4f5df43089fc96e35e51a55d0"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.21.3/cliamp-linux-amd64"
      sha256 "4c57503a3f34e4f3ca2b6d53680500ccdc7dcf8e7035e349f3bd91faaf0c1792"
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
