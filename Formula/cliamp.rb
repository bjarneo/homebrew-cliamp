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
  version "1.18.4"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.18.4/cliamp-darwin-arm64"
      sha256 "bad192008e0327ea3432fff4d5b2fe9f840449d81b744bbc8b601ac335c75c7b"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.18.4/cliamp-darwin-amd64"
      sha256 "304610cf7bb69e59d92f82b43d84898848775666d9ae48b36e9daf5d9d1d6855"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.18.4/cliamp-linux-arm64"
      sha256 "2a436b863ef49a44b664cd43fdfb9d34528d34e3d47d11c69377d04616f5c6ea"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.18.4/cliamp-linux-amd64"
      sha256 "052c61fe8f2c760b78eb71cb328403666330c3bcf9465a82be62b3a79c1a3503"
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
