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
  version "1.27.2"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.27.2/cliamp-darwin-arm64"
      sha256 "908e7769b04681b3d18310a50b9547dbdcdcf1584baa440cd2e9631f29555424"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.27.2/cliamp-darwin-amd64"
      sha256 "c0b7a61cfc2f684c6075e867ce87b7668deb0b6e81f93bf2fa3dc6f951dd7037"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.27.2/cliamp-linux-arm64"
      sha256 "7e13a0cac5a70fade59160e4d2ca3669cf84a8def67aa58b24978da10bc7c357"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.27.2/cliamp-linux-amd64"
      sha256 "6a2c11842c96c005bb10d1dcec8c8efd7ea0af49b55ee9ea3ab5a9a52f03cee3"
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
