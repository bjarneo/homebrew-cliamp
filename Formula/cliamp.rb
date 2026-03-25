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
  version "1.27.6"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.27.6/cliamp-darwin-arm64"
      sha256 "19b8993f9ddc11d0814be9e593bdc29bb357ad297c5e35c8d0126f1e6a0386be"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.27.6/cliamp-darwin-amd64"
      sha256 "f922f555e7ab8f9a98eb83f18b42137128ffdc5415fa51afec953a3463653c28"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.27.6/cliamp-linux-arm64"
      sha256 "4791db37d1c69c24a521b033cdead464bcf87f5bfc82cfac17f440d2aa637e6f"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.27.6/cliamp-linux-amd64"
      sha256 "5c82a6a940624f77e019c740fad0ec3fdf07fe04a93e7198bde33984af255f36"
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
