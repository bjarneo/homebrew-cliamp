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
  version "1.23.1"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.23.1/cliamp-darwin-arm64"
      sha256 "54f73a721969db1c6f7da83c42a2661319fb0566105d985e20c982f59a2d2f9b"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.23.1/cliamp-darwin-amd64"
      sha256 "566d8d8beba2536cf5b6090722bdd67c19ffbf95d04e95f8776731358eef9bd3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.23.1/cliamp-linux-arm64"
      sha256 "c36be582b0dff2768d569b7bb10189496edef56141a6df710a01b219d66a4452"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.23.1/cliamp-linux-amd64"
      sha256 "2014d6f34cd8bfb30fb9998fa49df60bf3d49961e7b5bf3d4bef88e678230d83"
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
