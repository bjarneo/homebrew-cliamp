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
  version "1.36.0"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.36.0/cliamp-darwin-arm64"
      sha256 "c36083ec68e1ae00e5a317ac7e0018cf8ef7ba3e45b37db1b54af154f67973cf"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.36.0/cliamp-darwin-amd64"
      sha256 "e00fa1390a2cf0d9a5495f78ad2fdafacf150918f14ccc100c73c9517c2c7dc9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.36.0/cliamp-linux-arm64"
      sha256 "89aa1eb7e74563e6fdec242d560bd732df261630dbfface28ac9cb1a83f0546d"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.36.0/cliamp-linux-amd64"
      sha256 "bc727d777719e3c0936b33a03c0c44f53161fde503a24c54b5a78316105f2522"
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
