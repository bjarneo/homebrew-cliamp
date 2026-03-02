class Cliamp < Formula
  desc "A retro terminal music player inspired by Winamp 2.x"
  homepage "https://github.com/bjarneo/cliamp"
  version "1.12.5"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.12.5/cliamp-darwin-arm64"
      sha256 "6c87cf7f34d75a8d4f44baee455a43730f29a913a237896b839c316fa0b9b140"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.12.5/cliamp-darwin-amd64"
      sha256 "295097cc2801005933900edf77d86a3798e5ac102b6c826fa35ae73175670c54"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.12.5/cliamp-linux-arm64"
      sha256 "9c27cfa12c0da6ac472cac797dda4cee72e93524c3ad373c97848f20242f5d80"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.12.5/cliamp-linux-amd64"
      sha256 "5d97052d0da86c48da0f378e9d36f168ebc772c886621ee3245d8da8557d775e"
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
