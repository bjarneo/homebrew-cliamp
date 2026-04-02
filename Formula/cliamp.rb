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
  version "1.33.0"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.33.0/cliamp-darwin-arm64"
      sha256 "03f35f1ac1b5e04373b3d7e258f4c65700a3a99bf2ae61285bfc09cfdbf90632"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.33.0/cliamp-darwin-amd64"
      sha256 "15e20fb77bbfd8d6080bf99ad7b4ffb4c6fb15eba0f5cafe4c0f93facd1e5e5f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.33.0/cliamp-linux-arm64"
      sha256 "fa3d28d764daeffa5afeb26130c0fe6210af516b1358ca57a74cfa0a83a3423c"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.33.0/cliamp-linux-amd64"
      sha256 "a06a93e6006ff87c04a1a3960b507a075d2594cb9929b608036c46655ef48e5e"
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
