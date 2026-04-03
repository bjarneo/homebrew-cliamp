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
  version "1.33.3"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.33.3/cliamp-darwin-arm64"
      sha256 "bf4beabc67fcb6b9534c61d7ca30c024564798c259c5c91d493a241a59329d9c"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.33.3/cliamp-darwin-amd64"
      sha256 "dd775b14a0a1812772e791441c31e90d4244409bf0f25f5c6b1e8d5ee2e2c053"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.33.3/cliamp-linux-arm64"
      sha256 "1d4c04377f76780bd78e8780844e70bab706ccfc760e9718f2729f38b606a78e"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.33.3/cliamp-linux-amd64"
      sha256 "8869c49a67283b06ec93b1bd885f218db9ea05d605103e84f458962a31f9524a"
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
