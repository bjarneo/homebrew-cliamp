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
  version "1.25.0"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.25.0/cliamp-darwin-arm64"
      sha256 "f040de2ce202986ea93009271ad77ad66997a378b200a64cd242bee28678ecf3"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.25.0/cliamp-darwin-amd64"
      sha256 "eac6f65b55fabd5066a3cc323423d112ae5381df7a7ae51b456adf5f30de3ae7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.25.0/cliamp-linux-arm64"
      sha256 "f8314ea0430a6756cf3654fb0c2184d1bd88afea977350b27fad48a3f982ca74"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.25.0/cliamp-linux-amd64"
      sha256 "0aa144695fb3ce5a826502d0d6b9c2ce532d77b143207381b027babd48a2a725"
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
