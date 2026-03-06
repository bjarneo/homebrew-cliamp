class Cliamp < Formula
  desc "A retro terminal music player inspired by Winamp 2.x"
  homepage "https://github.com/bjarneo/cliamp"

  head "https://github.com/bjarneo/cliamp.git", branch: "main"

  depends_on "ffmpeg" => :recommended
  depends_on "yt-dlp" => :recommended
  depends_on "go" => :build
  version "1.17.11"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.17.11/cliamp-darwin-arm64"
      sha256 "2dacd86a1bd8c729b9c4466458628c6772f092651a74f4f2f8d369486252889a"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.17.11/cliamp-darwin-amd64"
      sha256 "fd5b809c2ab734a0e7b4806ee3da9d83db226b88cae7e51c717b36869b57eda2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.17.11/cliamp-linux-arm64"
      sha256 "c83cdb3c972dea0560cf909fd94611a9bb3f65a152dd096b24dae70eb6ff2115"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.17.11/cliamp-linux-amd64"
      sha256 "83a9b7771eba5242c869443b9e3e253920381c3a46cf521a3a1de40acb8a870f"
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
