class Cliamp < Formula
  desc "A retro terminal music player inspired by Winamp 2.x"
  homepage "https://github.com/bjarneo/cliamp"

  depends_on "ffmpeg" => :recommended
  depends_on "yt-dlp" => :recommended
  version "1.15.1"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.15.1/cliamp-darwin-arm64"
      sha256 "9057dcc0789fc592293d1c2380ddc8b8911fb0e9631b86455de3426c400a0dcf"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.15.1/cliamp-darwin-amd64"
      sha256 "d6e35930ca1edf96694ec074b0857d4342b3af78c82566dfbebe554ec0fde7f0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.15.1/cliamp-linux-arm64"
      sha256 "5119583f3b61412d0005d365ab7d79547d95f84b5a4b341b5443f0b66b526d2a"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.15.1/cliamp-linux-amd64"
      sha256 "d6d456bef309652eb5520afceb6ee44714f4f4435fb27ba91e995cd98e42a9e6"
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
