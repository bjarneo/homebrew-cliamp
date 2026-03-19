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
  version "1.22.1"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.22.1/cliamp-darwin-arm64"
      sha256 "9b9884fa731f50282fb9eb91a28e1adb0aa0de6b491565276fedc92fe48bcc54"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.22.1/cliamp-darwin-amd64"
      sha256 "a8961a405951f4f5daba264e2b3c003302ed8bb8d8e40ec09598b529185e4a0b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.22.1/cliamp-linux-arm64"
      sha256 "2da82b7fa9f8252ff530b477f2776ff85eff4cfc4455fdc60d9781578594e1dd"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.22.1/cliamp-linux-amd64"
      sha256 "1ebaf134ae6a01f419bbdf6b8a8a736bcd295cdc4e699145f92cda70391b3e67"
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
