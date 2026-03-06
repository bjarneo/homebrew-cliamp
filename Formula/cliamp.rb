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
  version "1.17.13"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.17.13/cliamp-darwin-arm64"
      sha256 "4613c84293abf7f995836b9078b9954deba14390cf08580338dc195c7fb75952"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.17.13/cliamp-darwin-amd64"
      sha256 "16d8ac5027d4e9a5e332ca60316b787ed26162d210d5b2d851aa320d25ae7303"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.17.13/cliamp-linux-arm64"
      sha256 "50c5141733000135ac8ab9dc87c6e4ec4918d616e9bb34613f1a32c115dcc0ca"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.17.13/cliamp-linux-amd64"
      sha256 "ee75f521e10bc82404ba5b2ce6a130f4c689f48c67648c26f9f5873929c50a30"
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
