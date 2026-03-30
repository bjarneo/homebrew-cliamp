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
  version "1.29.0"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.29.0/cliamp-darwin-arm64"
      sha256 "a4054c59d6763cb417748860f7fda86e2263afa57fca65ba3f1167566c67b55f"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.29.0/cliamp-darwin-amd64"
      sha256 "7f2b9ccbb976f88425b2edad12eec32f20b2973933b107d8150a2d88dbcec50f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.29.0/cliamp-linux-arm64"
      sha256 "e9e73120d22e3794a38c36e77f783e8e5668314b27df36dac079c96df434e46c"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.29.0/cliamp-linux-amd64"
      sha256 "3351a68bf773299670295ebdb09103682e663a994e4e14ed1b115db35a0f5d94"
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
