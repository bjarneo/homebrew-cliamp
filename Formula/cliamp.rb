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
  version "1.28.1"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.28.1/cliamp-darwin-arm64"
      sha256 "d4d844aa21f1901ada367bbb8c2aaf1eec3a0bfaa0ae248f3f1f66bf8cd3f736"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.28.1/cliamp-darwin-amd64"
      sha256 "8384a2c3eaf0afefbd630333e6e8ff5ef61549b3fa1ac07a0f0f8998e11546e7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.28.1/cliamp-linux-arm64"
      sha256 "360dd1a31778a2b4a1877ce3e6e7c47e7c325d21e488163e2347ba15247044cb"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.28.1/cliamp-linux-amd64"
      sha256 "2ceed0b4c9d5661d5083b5479979e0bbfe6e3d590115e299cca773803e791354"
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
