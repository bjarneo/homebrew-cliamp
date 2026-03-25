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
  version "1.27.3"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.27.3/cliamp-darwin-arm64"
      sha256 "03f3a7f564ae26a0577a14c00697ba8aa07d8fb22645677af53bc6350d640207"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.27.3/cliamp-darwin-amd64"
      sha256 "3964a95b8de2525b898df4deab6d220eea73e32ad01da6316c354c376dbadd1c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.27.3/cliamp-linux-arm64"
      sha256 "cb3e8e1749db79b40adc6f7d2cfc519a9e5015fc9b2f1011790944019f333374"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.27.3/cliamp-linux-amd64"
      sha256 "fe0c3d976ae1ca6c11c1d486235500150a89e95971360d35354dae97925f3de7"
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
