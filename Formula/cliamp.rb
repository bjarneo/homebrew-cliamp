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
  version "1.21.2"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.21.2/cliamp-darwin-arm64"
      sha256 "f2d47ed397698664487c552cddb18c6330c549a25263b220eb8e7adedd60c522"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.21.2/cliamp-darwin-amd64"
      sha256 "e49425f355de864bb71aa5532154abc3ed84c26e5a51a601554f78f477b24e15"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.21.2/cliamp-linux-arm64"
      sha256 "523cb29506e16671c2ccb8ce2a52f2377e6c2e638d2bf94ff0d4cd233a55b32a"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.21.2/cliamp-linux-amd64"
      sha256 "b585d00191efc89c3e7d4e12842938e1b2d98037e741080f575c4a391389684c"
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
