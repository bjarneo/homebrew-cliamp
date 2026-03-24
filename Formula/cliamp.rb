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
  version "1.27.0"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.27.0/cliamp-darwin-arm64"
      sha256 "b8623c8203beb1f62ea36de82751602c639af766cc652e6ddaf51409c6e739c1"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.27.0/cliamp-darwin-amd64"
      sha256 "66c48d2f281cbf82b623e6cebbf731f87bd01a3170f411a0a04afea23bb28172"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.27.0/cliamp-linux-arm64"
      sha256 "74a026fd126136a1168468ee8c7a7a1d8f322bc468d997075f6bce2243edcd31"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.27.0/cliamp-linux-amd64"
      sha256 "1458926337183a2d1f858f53ed9153aad937ea41447760267d9a95fc352aecdd"
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
