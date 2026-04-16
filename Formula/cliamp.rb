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
  version "1.35.2"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.35.2/cliamp-darwin-arm64"
      sha256 "a71456af85cda54bbe7c29d888a769ccabdf972c2eea18a08d0755be55ffb7cd"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.35.2/cliamp-darwin-amd64"
      sha256 "05a3c126fb63e2856aed82c1b9a01ef5b950dcbef0871edb47fa6eaa976c455e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.35.2/cliamp-linux-arm64"
      sha256 "60892f36d2586b85b19018c8ce8bbef710ca15e872bd554f69ce12e90711d534"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.35.2/cliamp-linux-amd64"
      sha256 "856fe3b564570a896e3657fc77e1f6c4afd3fad67d9b227872301f438609d32a"
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
