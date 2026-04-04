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
  version "1.34.0"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.34.0/cliamp-darwin-arm64"
      sha256 "5f6c7f3a4c2ac81aa664a0276bed8e5b267611d4ecd74229cc5793a4cd318156"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.34.0/cliamp-darwin-amd64"
      sha256 "60a407ed75e022b59fc8dd4357912df348710e8fe6e6c67d347044118a99facb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.34.0/cliamp-linux-arm64"
      sha256 "6ba1849b8de2e8a6ac8cb38f036a7dcd8b3cea485f8fd900b5c9cf3513356871"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.34.0/cliamp-linux-amd64"
      sha256 "0ab104dd31a4bef40f48c557e9c7d42bfa5223dfa86ca3c241ab01bdd70dc03e"
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
