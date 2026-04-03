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
  version "1.33.6"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.33.6/cliamp-darwin-arm64"
      sha256 "70390015ac078e234295288f3abe4637ff0a399a489fb731a73a131974cb8780"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.33.6/cliamp-darwin-amd64"
      sha256 "17e7b614c2f48d238cd3b3635e7a5ae872cf03b7196887c277054b310eda8f22"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.33.6/cliamp-linux-arm64"
      sha256 "ada7fb9cffa0fe6d9eaa977960b2f9b50c312f2b7b6bd5fdf6679da19ec3cbb5"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.33.6/cliamp-linux-amd64"
      sha256 "5f10a2d200d96d5dc93fcfc02dbb678fe9725d8cbeff91b4a3f67ec778c96783"
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
