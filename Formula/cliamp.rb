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
  version "1.27.5"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.27.5/cliamp-darwin-arm64"
      sha256 "42b394dd4fcc51e15fff8de50f8a7de1cfd07fa6f24575fea5fe8603b070cd60"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.27.5/cliamp-darwin-amd64"
      sha256 "22ea7adfd1617731507bdf7b52c1cc176656ff83511df2bdb02d4e52d1d0bc11"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.27.5/cliamp-linux-arm64"
      sha256 "1ae65ce4d76b952a45e9c903fc3a4312a0cef70292f1ecfa3cbc09b6c439046f"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.27.5/cliamp-linux-amd64"
      sha256 "576f97832a2c153805cefc7c874ae7371e43c04298e8a4b23716c1dba28d1f7c"
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
