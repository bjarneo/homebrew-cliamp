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
  version "1.21.4"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.21.4/cliamp-darwin-arm64"
      sha256 "20b760d6236fc5de6c4783708220afb760b1296776c77389029d6e644bc09a98"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.21.4/cliamp-darwin-amd64"
      sha256 "3f8a40a8ded5d0ced746af06cc555a012b6aa77b9636ca442aabfaf2289581c5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.21.4/cliamp-linux-arm64"
      sha256 "693d691dab37fb4453732ff42ab8f67201c268b011c1f4ac0462b49cd1f47f0f"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.21.4/cliamp-linux-amd64"
      sha256 "8fb13e7237b1ef4758607cf276b1cfc0f3de973324d5e05b5dccba67e385a0c0"
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
