class Cliamp < Formula
  desc "A retro terminal music player inspired by Winamp 2.x"
  homepage "https://github.com/bjarneo/cliamp"

  url "https://github.com/bjarneo/cliamp/releases/download/v1.13.3/cliamp-darwin-arm64", tag: "v1.13.3"
  head "https://github.com/bjarneo/cliamp.git", branch: "main"

  depends_on "ffmpeg" => :recommended
  depends_on "yt-dlp" => :recommended
  depends_on "go" => :build
  version "1.13.3"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.13.3/cliamp-darwin-arm64"
      sha256 "e6544f4f82facbb54b87ed3486febdafbd592521453c665aa3be3b71fa759c12"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.13.3/cliamp-darwin-amd64"
      sha256 "c0129fda93e64cee4b669c5b432553db20c264fb9479a9de35d4044a4943ee90"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.13.3/cliamp-linux-arm64"
      sha256 "82fd8a045c7718499b9d55fd02724362d9c334fc74234d0929529283792bbbba"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.13.3/cliamp-linux-amd64"
      sha256 "04f21b10929555518b4421fda66f981d3263c2f1c70484abb40780fb0765eba0"
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
