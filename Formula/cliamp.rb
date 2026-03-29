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
  version "1.28.0"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.28.0/cliamp-darwin-arm64"
      sha256 "40c62b21af6ab997fb9985c6dcd92b809a1399f77648c98147308faec27ad62d"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.28.0/cliamp-darwin-amd64"
      sha256 "485a69b89759ddfe82ca1d37f89efae922f53ae8385a79afc69a72300aa73dcd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.28.0/cliamp-linux-arm64"
      sha256 "63092711a17efc960ce1f807494f78cedb44e33b5c65ecd2e5949cb7353ccc76"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.28.0/cliamp-linux-amd64"
      sha256 "838db28b6f0bc8d7dcdc85b05235d9bc09c4e59e0bb96bc941d53ca5e23a60df"
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
