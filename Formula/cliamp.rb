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
  version "1.20.1"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.20.1/cliamp-darwin-arm64"
      sha256 "50c13d78cf843db0da1c2fcf5c5c9994284523e4137b8c914aa8299f2fb79523"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.20.1/cliamp-darwin-amd64"
      sha256 "dfc149c619b378d114f345546ca870f5ffd46201b4a124629091771732f59320"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.20.1/cliamp-linux-arm64"
      sha256 "cc898cdce975a510c4d71d4d685bbac4ae0f6f2ec3ef993e87f12e8fc634bf14"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.20.1/cliamp-linux-amd64"
      sha256 "5091b66e402b78953295de89407a5fe2a45b0fb39c85067f3ea470a8ced94717"
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
