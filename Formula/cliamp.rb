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
  version "1.31.2"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.31.2/cliamp-darwin-arm64"
      sha256 "bcf98982bb433a176d6c3de4fc6419dfc252fbbd7599030e316b31ffd30160d5"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.31.2/cliamp-darwin-amd64"
      sha256 "8d3c89fe3812927dfee3cdec45ce7a2ea8414e37e4fdf5b47bacb1fc272d5c85"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.31.2/cliamp-linux-arm64"
      sha256 "b51d6312d73202bdbe286dd273a7f7e323951dd15a8aaa20a73b4347bb920c67"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.31.2/cliamp-linux-amd64"
      sha256 "a6ad4aa9161000a7ef9aee7d35667ffe96045cb40617aaff1d14845b081859c5"
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
