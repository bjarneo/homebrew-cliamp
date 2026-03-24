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
  version "1.27.1"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.27.1/cliamp-darwin-arm64"
      sha256 "623d478dacba375727c7917b3f7ef62281edec4b0866bd837db1c34d0d296f07"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.27.1/cliamp-darwin-amd64"
      sha256 "929f8120ae37ce43291e07a0013bafb69a7dbadea4717f789a7b4fd05ab007c9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.27.1/cliamp-linux-arm64"
      sha256 "c7f3337c5405171852fe171256c33acc39d9979e2d87700e0c571181e70281a6"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.27.1/cliamp-linux-amd64"
      sha256 "394c1ff0b5ef9e9a572114fe1e45ff05ec98ad4eef767f118e5d43e6eedeba0d"
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
