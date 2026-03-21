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
  version "1.24.0"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.24.0/cliamp-darwin-arm64"
      sha256 "127cae43e46c104f4cf8ad87453ccf482a870ba2c7b3ac121533745f2d5c2ddd"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.24.0/cliamp-darwin-amd64"
      sha256 "109f2dd96dee5471b2560ee8378fa16dae264bb744cd65e6435f5f19ad49bb7e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.24.0/cliamp-linux-arm64"
      sha256 "51d3c5c96e0e8c86a439e7b239d785beb9a9a8fb355916b2a0e90175d2f5145e"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.24.0/cliamp-linux-amd64"
      sha256 "6ce972ca004f1f28312d958358e56b5881dfc3c73b0f9f4908cf4f3ec086413c"
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
