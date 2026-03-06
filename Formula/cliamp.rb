class Cliamp < Formula
  desc "A retro terminal music player inspired by Winamp 2.x"
  homepage "https://github.com/bjarneo/cliamp"

  head "https://github.com/bjarneo/cliamp.git", branch: "main"

  depends_on "ffmpeg" => :recommended
  depends_on "yt-dlp" => :recommended
  depends_on "go" => :build
  version "1.17.9"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.17.9/cliamp-darwin-arm64"
      sha256 "74aa0dc59677275b8962a1b44249e5b7fb6c632fe96d5d878d220a2d3e43feac"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.17.9/cliamp-darwin-amd64"
      sha256 "6bfd52182dd7315f3d7d29dd4c2ac3d45772f9902ca48087099c027f85582d5e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.17.9/cliamp-linux-arm64"
      sha256 "56e5952b8dbd4a559383c4ef1f4897fe783b8144b4003f9ca10abdc92f2e3f96"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.17.9/cliamp-linux-amd64"
      sha256 "b78ae0ee90f9b93ed7a14c5572c903272639d8c31c224d9269da9ed985c0872c"
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
