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
  version "1.24.2"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.24.2/cliamp-darwin-arm64"
      sha256 "392c55058dc4ff715b499f31fd0a5c5e81eb1c582049931a2d491ec41edba7d5"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.24.2/cliamp-darwin-amd64"
      sha256 "50ce1ed6479975952e03245e1dd3b2cac38ffa28ef897b4e05cfe2202b1cb93e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.24.2/cliamp-linux-arm64"
      sha256 "24eae69684802e6db32a909bf1233de2bda17b7a0f3221a9d5ebfec45b803332"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.24.2/cliamp-linux-amd64"
      sha256 "145328a58614b5e308994e59ca0ba07ab7a22f7439afc16f7d8caaa6c5fe00ba"
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
