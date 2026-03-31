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
  version "1.31.6"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.31.6/cliamp-darwin-arm64"
      sha256 "8bbc3565030d683562d847c0c479f752063b83013945d73acdb005e6ed59b517"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.31.6/cliamp-darwin-amd64"
      sha256 "e16cc4bbc3da6a05710cfce149dbd95920257d5187abc65be6a15e12b509a4db"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.31.6/cliamp-linux-arm64"
      sha256 "5e6296a8f5c9b1bfb442baaf90a792ba25c3ac45246d05b6d31e1a9bd5842d5a"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.31.6/cliamp-linux-amd64"
      sha256 "3b1a9c28cac4e064d4f2071a3044813b5f9da94ea342decd8488e4e6d8fb826e"
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
