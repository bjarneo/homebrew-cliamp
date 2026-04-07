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
  version "1.35.0"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.35.0/cliamp-darwin-arm64"
      sha256 "954f90e5256d736884b965694af1525db06a35b844d926e99e69a21121fa51b4"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.35.0/cliamp-darwin-amd64"
      sha256 "a52e46ea96389998f0f5d6b998cb12ea273d78a2e06dd7684a546733ad78f94c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.35.0/cliamp-linux-arm64"
      sha256 "4b24adb45840230477fceced0a0c87854f830501778755e20a78f72ba46ef530"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.35.0/cliamp-linux-amd64"
      sha256 "8665938706fcfc4b04ada55d629fb771130703812fa00e1c55152e7cfd4f0493"
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
