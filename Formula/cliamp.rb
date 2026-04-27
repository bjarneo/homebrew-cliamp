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
  version "1.39.1"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.39.1/cliamp-darwin-arm64"
      sha256 "f5653867fa645ece88daebe4b74efe2d42f990b78f476d3f9ab22e20fe172233"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.39.1/cliamp-darwin-amd64"
      sha256 "5e3b537407d8defc34e05843415180bf356862eeeb1911690d9587f7f7e93cc4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.39.1/cliamp-linux-arm64"
      sha256 "2cc1f156a3cff8816425ec426943f7401bc9e807c59152923a3d87a4c48634eb"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.39.1/cliamp-linux-amd64"
      sha256 "c2e763dbd0ba77ece9ab523793762c8716bb0ab34d4bc8c5f074b493eb4bb4be"
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
