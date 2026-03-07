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
  version "1.19.0"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.19.0/cliamp-darwin-arm64"
      sha256 "c3a5113e4d2d338ce7d004280b7a1e71a804f78e711d05aef1d3a5c72118015d"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.19.0/cliamp-darwin-amd64"
      sha256 "080b07d3dfff3284465a2064efc08b3ac6f18db3f2fc23683cbd27ce05d073d3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.19.0/cliamp-linux-arm64"
      sha256 "b69cd46113f4f5faa6af8ea7195c80980b6f9b134ce32a3822682fcf43fd8364"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.19.0/cliamp-linux-amd64"
      sha256 "0f848a85bdeaf88b394993d8bd01cb4387996094afb2bd288738776f8973ab2b"
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
