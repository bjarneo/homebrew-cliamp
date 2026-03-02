class Cliamp < Formula
  desc "A retro terminal music player inspired by Winamp 2.x"
  homepage "https://github.com/bjarneo/cliamp"

  depends_on "ffmpeg" => :recommended
  depends_on "yt-dlp" => :recommended
  version "1.13.0"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.13.0/cliamp-darwin-arm64"
      sha256 "44c160b2b6f5b8e8b6ecca037618eab775920efaf3d2802f2101bf54bc33e2d5"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.13.0/cliamp-darwin-amd64"
      sha256 "0d99748b20d92a808d01c5365daec29a51f8cb3dfc264dd1b3526f85f81150f0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.13.0/cliamp-linux-arm64"
      sha256 "685abd94f76f6e067889a6a14c703967895dfa549b0463eed8130e33101ffb47"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.13.0/cliamp-linux-amd64"
      sha256 "68e9ef105cedd3bed00e3802454b5abe9fd42166837cd62c4df81ecacf69fd4d"
    end
  end

  def install
    binary = Dir["cliamp-*"].first
    bin.install binary => "cliamp"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cliamp --version")
  end
end
