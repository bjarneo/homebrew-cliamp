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
  version "1.33.5"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.33.5/cliamp-darwin-arm64"
      sha256 "576d114b4a1814151e8de4c826b331b7e8182847abddaa8234dcdbdb77c8cddf"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.33.5/cliamp-darwin-amd64"
      sha256 "3e22e0b2600f8cd6f6720ca3fc87a6a1d2f60ea3ee6a78d83a9484449d8e6e98"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.33.5/cliamp-linux-arm64"
      sha256 "8984c47de78e7fdf8b02bfb1f49f519386d958c72aaa1288e0b1f62791c90a58"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.33.5/cliamp-linux-amd64"
      sha256 "a1c35a195656ffe5e5a8ff5d94973591642f388856127320a534c185f6c5ec41"
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
