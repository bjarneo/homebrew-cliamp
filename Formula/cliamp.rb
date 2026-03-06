class Cliamp < Formula
  desc "A retro terminal music player inspired by Winamp 2.x"
  homepage "https://github.com/bjarneo/cliamp"

  head "https://github.com/bjarneo/cliamp.git", branch: "main"

  depends_on "ffmpeg" => :recommended
  depends_on "yt-dlp" => :recommended
  depends_on "go" => :build
  version "1.17.10"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.17.10/cliamp-darwin-arm64"
      sha256 "97cf5ae8cdf272512092255ca69793f7297cb73e8cd44e937fdb8b0953170cbd"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.17.10/cliamp-darwin-amd64"
      sha256 "9e717a69b747f93b4b42f70f3c4ce1720f2621f6ee3e0845df241e1f4a9e5a79"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.17.10/cliamp-linux-arm64"
      sha256 "0e92d38843f98fa33dee433dedcf9c046a27ce0e263e7d23d392832888c8ae1a"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.17.10/cliamp-linux-amd64"
      sha256 "f49c2c952930c2658f0fb133097b792338b501aca67fec25d8e37ea9e050415d"
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
