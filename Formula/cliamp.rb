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
  version "1.24.1"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.24.1/cliamp-darwin-arm64"
      sha256 "73bbec227203f31afc0a63e0851731461f108a29d92bff20fd72007595c5717a"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.24.1/cliamp-darwin-amd64"
      sha256 "cc74211bcf234a603e0dcdbb68b876d3d810ee7d065362a33011a3fa9ae6321f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.24.1/cliamp-linux-arm64"
      sha256 "7f802dbcbed3e10a4c94c23e76d5d7010ffc3a4efba87f865d772c06b82a5db9"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.24.1/cliamp-linux-amd64"
      sha256 "a24117dc4b6e0abb522fdb383013c8b5ad20f8df95e096de6a820ef0201aa99f"
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
