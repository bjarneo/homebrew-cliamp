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
  version "1.31.1"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.31.1/cliamp-darwin-arm64"
      sha256 "5de19af58a299491517d689ae3ab5ddcbd500605ee5450e49b993df5e94f2f3b"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.31.1/cliamp-darwin-amd64"
      sha256 "80abcc64667a9faf6012cc57039934c18be29569d90c472107468215b6cbcaf9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.31.1/cliamp-linux-arm64"
      sha256 "01389161dc0682200dd0146eb569705bc092a483f76019a341f0e6f1797d192e"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.31.1/cliamp-linux-amd64"
      sha256 "c964ea72c8ca79d02a0309b0eefe23b3f2594c9e72649d3689e73683f635f064"
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
