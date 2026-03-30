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
  version "1.31.4"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.31.4/cliamp-darwin-arm64"
      sha256 "77261e0b984c2d419dc0f3b8fe7320a1fb2fec95614d92b4b67c3a7d7ea144c0"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.31.4/cliamp-darwin-amd64"
      sha256 "6c0b336e7994b440acc11c010dee37c750b804ab3e4cbb7bc273270ee7427a04"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.31.4/cliamp-linux-arm64"
      sha256 "8865897edfd3d3e7e87220974dc14ba58be5a7d000b04b14cc48bb72b3e27ef0"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.31.4/cliamp-linux-amd64"
      sha256 "a59357b3213b420662997bffea809f0c2abab0a135228ef571361127c42c463e"
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
