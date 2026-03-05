class Cliamp < Formula
  desc "A retro terminal music player inspired by Winamp 2.x"
  homepage "https://github.com/bjarneo/cliamp"

  depends_on "ffmpeg" => :recommended
  depends_on "yt-dlp" => :recommended
  version "1.16.0"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.16.0/cliamp-darwin-arm64"
      sha256 "65e046549b111233aea40f2637a47e8674dd9c437686658255c52577fd7209b9"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.16.0/cliamp-darwin-amd64"
      sha256 "8719d340a85b0b1b1aa22c8762dc9272ccc441e202161b1f2da65dfd1a15844b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.16.0/cliamp-linux-arm64"
      sha256 "235754a043aa304f9f2b9d34d32de1372d96f40ae28a048e506f3985c858d393"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.16.0/cliamp-linux-amd64"
      sha256 "af71a6d0a740ef98d7296b2f6bd253e47fd579f21c230283f1a7491a64e2d908"
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
