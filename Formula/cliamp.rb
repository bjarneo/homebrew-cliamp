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
  version "1.37.2"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.37.2/cliamp-darwin-arm64"
      sha256 "d85966ff7fa9ee26e03acdf4b7149d12979ac964dec2877ed267b9a73f409892"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.37.2/cliamp-darwin-amd64"
      sha256 "25d3ddba9883ae07a24a74298bd99345b86263ea047dc41b29fa0f669c1afec5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.37.2/cliamp-linux-arm64"
      sha256 "b299f3d67a9c664dea74a06aec35cfe9ee241c1d1b7bd56f10c931fc8d0ec0f3"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.37.2/cliamp-linux-amd64"
      sha256 "e1a1ce3a1d7ebc093a4f22e4d354da175f53219d69efbaf68bbfb317acde4a0a"
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
