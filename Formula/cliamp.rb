class Cliamp < Formula
  desc "A retro terminal music player inspired by Winamp 2.x"
  homepage "https://github.com/bjarneo/cliamp"

  depends_on "ffmpeg" => :recommended
  depends_on "yt-dlp" => :recommended
  version "1.13.4"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.13.4/cliamp-darwin-arm64"
      sha256 "b0899f75fa56a90c2459d148f934931af1ceb41aaed7bb0065fe77b051f39ee4"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.13.4/cliamp-darwin-amd64"
      sha256 "5090b12ee85192d8c3839ff52e1a5ac53623c26eae9bfdfd330d79cf98648a8f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.13.4/cliamp-linux-arm64"
      sha256 "dda56f568600b22e956e61d2fe10da6bb38bcef5e01f4145480a9320f615603f"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.13.4/cliamp-linux-amd64"
      sha256 "8d43af351e1940eabf179b73bff76c5f5138502136063b384ccf19866450e932"
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
