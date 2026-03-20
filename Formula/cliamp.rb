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
  version "1.23.0"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.23.0/cliamp-darwin-arm64"
      sha256 "95e4c0cca561726453847f106061ea436e166dc77fa757e33df614491d14c660"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.23.0/cliamp-darwin-amd64"
      sha256 "121f852db29cb1cd0f98519daa32c6e8ca2aa61fa4b47e2e554fd231ec57f7b0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.23.0/cliamp-linux-arm64"
      sha256 "a79e8bd62ba44ef5ea07821064c1e05249d5458b2b224d8969ca39b1cacc9a20"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.23.0/cliamp-linux-amd64"
      sha256 "86f968f12fba2f8292eeb26e1a51df42b4df03c85bd177e31d6f212e626b5b62"
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
