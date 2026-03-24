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
  version "1.24.3"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.24.3/cliamp-darwin-arm64"
      sha256 "1329e5443a11f5b8a73dbd15e2ce579b5137cf1a1b11140c243f682f7deea611"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.24.3/cliamp-darwin-amd64"
      sha256 "218881055dd24d74842d0c07eac476f4d09a85bf94f42fc31cee96fc8c1d40ef"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.24.3/cliamp-linux-arm64"
      sha256 "a8d6e1bfe6226d6d7d115df94a6d2b953647916541f766fbe594d80631c309a5"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.24.3/cliamp-linux-amd64"
      sha256 "22a3c4589004f61fee5706e0b7c0ca5091ca8eb76202292cfbedf82fff5f4151"
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
