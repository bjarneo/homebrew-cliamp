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
  version "1.38.0"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.38.0/cliamp-darwin-arm64"
      sha256 "d9461166b01b26f5796b2de897e233009f2b3721e42efeb78cda7c443fb0ed4c"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.38.0/cliamp-darwin-amd64"
      sha256 "dce26b92ec4e3044c8bc44b70171a89fb60f0041534a351a5a1032892cfd2920"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.38.0/cliamp-linux-arm64"
      sha256 "f91ec577a3f7350ba0901d6c4dbaa6313c552cc9cf73ed386d1fbebd8f20a9b5"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.38.0/cliamp-linux-amd64"
      sha256 "8d9b70bbf2de8ca650fae2669f993b0d7cf29b1df8dcb896dd90b67420d103b3"
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
