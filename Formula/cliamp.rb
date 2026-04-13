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
  version "1.35.1"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.35.1/cliamp-darwin-arm64"
      sha256 "7be15003217a6bc8da6b8ffd9fb9491219b1a778de01788231bb452a33f8b5bc"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.35.1/cliamp-darwin-amd64"
      sha256 "a28e1539be7322a728c41e23f5c9c94d597fc72004023825601cc3281199ec2b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.35.1/cliamp-linux-arm64"
      sha256 "e5295ef1eff0a8d0cc9b82f65d273cf2d7e93b96a84d4511aad2fe233fa8cb97"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.35.1/cliamp-linux-amd64"
      sha256 "67831439bb6164bd510961bdf16a0622c0a4a44eb247a82563e28486e5d7220c"
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
