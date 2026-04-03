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
  version "1.33.7"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.33.7/cliamp-darwin-arm64"
      sha256 "7e1b9fa5cf5c398fb613938d6a995d19d21827d1961f44b0d4128ca08426c04b"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.33.7/cliamp-darwin-amd64"
      sha256 "1e92c5810898b05d5ed340a160b290b242c2e362de7a8da58dc59a15ad274a18"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.33.7/cliamp-linux-arm64"
      sha256 "96b74b96aebbab4b285e8b2dd6b25ae4fad9a1aa0e863005b0ad367d2dc38186"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.33.7/cliamp-linux-amd64"
      sha256 "35b998bb5d994929d98b7bab070d52ac6a73f46594ebcb0764349b9d08b6108f"
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
