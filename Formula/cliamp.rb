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
  version "1.33.9"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.33.9/cliamp-darwin-arm64"
      sha256 "59491fb5b133a6cf77cae6a4a668ea6ea77095778e8b0d59856a61a879c514cd"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.33.9/cliamp-darwin-amd64"
      sha256 "22e1acd3f473a4efa2a46c34fe9e9dd0315dc6d0446faaf59ee1351ec3980735"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.33.9/cliamp-linux-arm64"
      sha256 "894cf4b34ae858ab567a73b0d58b5bfcee577374c6b7f3b614cb697f0eb1704a"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.33.9/cliamp-linux-amd64"
      sha256 "4f41bc28c7b66868219761ff3067759b90c2f6f94fdcfa020c6cfea26d03fe83"
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
