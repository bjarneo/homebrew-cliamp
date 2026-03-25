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
  version "1.27.8"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.27.8/cliamp-darwin-arm64"
      sha256 "1b22511f7bfa4f6d31a3a759101fefb41437915c8465a5506479ef6e0a9cccd5"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.27.8/cliamp-darwin-amd64"
      sha256 "fc262bbf645377adce7df20c5b480ddd6b83f4c425b17547905c43ad98b83ebf"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.27.8/cliamp-linux-arm64"
      sha256 "206a94ecccfed4a6c933144b5dd7af875c9a05d6dbada5d09fca72d9dc5dbfc0"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.27.8/cliamp-linux-amd64"
      sha256 "360e3b06378b7150fdf7537c948cf77e23a8121b775402d58d948c9b70d6d45f"
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
