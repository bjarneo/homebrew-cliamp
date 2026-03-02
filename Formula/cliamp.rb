class Cliamp < Formula
  desc "A retro terminal music player inspired by Winamp 2.x"
  homepage "https://github.com/bjarneo/cliamp"
  version "1.12.6"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.12.6/cliamp-darwin-arm64"
      sha256 "07733bda85f8ca155012a6fa817a931742a83bc0aab471cbe8ab89d32e20153a"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.12.6/cliamp-darwin-amd64"
      sha256 "a7f86ce40cf80a37983ccc1e2117e506f219ab0f73aa7e919794fff2bd208ecf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.12.6/cliamp-linux-arm64"
      sha256 "ab429b150dab4eb1ad0d1a166255c83bc72ef6d0ddfcf56e41e939648d455508"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.12.6/cliamp-linux-amd64"
      sha256 "f9271c69f734f98e4d4cf92d9ae0b315c8c7ab2c4dec6067d35c10b467f7eb56"
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
