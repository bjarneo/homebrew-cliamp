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
  version "1.30.0"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.30.0/cliamp-darwin-arm64"
      sha256 "a5345aada4481ec152e338735647585efe83af380b5bc463e3127bc809e0e666"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.30.0/cliamp-darwin-amd64"
      sha256 "32653457445135503f0b2b079bda44d333a7e4f48f58a5591c54db1c1f0b93bb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.30.0/cliamp-linux-arm64"
      sha256 "83a6ac03129cc2ac768344e713110f2001aa42a6c5170b12813956b0e728c0f6"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.30.0/cliamp-linux-amd64"
      sha256 "4f179cd9430214dfee5c9d99dc04f2ed2fff365b1e6177c19325fd86487103f2"
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
