class Cliamp < Formula
  desc "A retro terminal music player inspired by Winamp 2.x"
  homepage "https://github.com/bjarneo/cliamp"

  depends_on "ffmpeg" => :recommended
  depends_on "yt-dlp" => :recommended
  version "1.13.1"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.13.1/cliamp-darwin-arm64"
      sha256 "222513250787b8efb7d9492ac5c0184b555c69444918a0d2fd69d47a781a64ac"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.13.1/cliamp-darwin-amd64"
      sha256 "981b782133f891e5f6b30ad15e50675ced3bcbbcda7f4bab4434ae03fc857228"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.13.1/cliamp-linux-arm64"
      sha256 "12c3f8f12a08d99d31ff1faa2c268e51181d062c9659ab4cb0d07e96092e997b"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.13.1/cliamp-linux-amd64"
      sha256 "4b2af55c70a166760157a91e2ddd3644d4be82753e542acefc07e7d3d638293d"
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
