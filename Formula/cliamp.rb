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
  version "1.26.0"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.26.0/cliamp-darwin-arm64"
      sha256 "9cbaadaa88a41a9e8d8ae8675610824d45ad079abb745dd3f357484d273b5d60"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.26.0/cliamp-darwin-amd64"
      sha256 "d0378e180d1896f86a5cd0fe0aa0028528e353c1149a2c028e11d6319e65250e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.26.0/cliamp-linux-arm64"
      sha256 "c1fb5234ae664b6916bc79c27915f028e3a1a719cee3ab4ba1ec92a6d465ac85"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.26.0/cliamp-linux-amd64"
      sha256 "19a472e796516dc88b0d68c5b06518fcbcc280116b585c4e35831846b790b8f8"
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
