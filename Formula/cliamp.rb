class Cliamp < Formula
  desc "A retro terminal music player inspired by Winamp 2.x"
  homepage "https://github.com/bjarneo/cliamp"

  depends_on "ffmpeg" => :recommended
  depends_on "yt-dlp" => :recommended
  version "1.14.0"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.14.0/cliamp-darwin-arm64"
      sha256 "1b8bed46b3a52a3966e06ace5cf9debc8d7a2088b3f1ae3550325a1ac7a409d0"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.14.0/cliamp-darwin-amd64"
      sha256 "479b0d388fa576f0d369aa9935f2bdbb2b53ffceb87bad79eee324269713cdec"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.14.0/cliamp-linux-arm64"
      sha256 "e919802fbc231102157eac9c4c39cb260b2e6fea7bef39e3cc5576438fe3f379"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.14.0/cliamp-linux-amd64"
      sha256 "97537c62a109c1a6853c83a511cb6ce7b6c4c73a00daa199f0fc3255d97f163b"
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
