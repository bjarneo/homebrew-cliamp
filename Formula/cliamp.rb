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
  version "1.27.7"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.27.7/cliamp-darwin-arm64"
      sha256 "6bbed3a142b473c87e85d372230e7103c9f19dca71cac30fdf0401aac8db868e"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.27.7/cliamp-darwin-amd64"
      sha256 "de4a7431075547aef643de43eafa03c7e79505d6251db806b7927d8a8dd702ac"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.27.7/cliamp-linux-arm64"
      sha256 "d5a005487fb455a942f000bbd288a8ca76d12b467013d16b2694c103d65d917b"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.27.7/cliamp-linux-amd64"
      sha256 "908ebddca6e3a6c63be0eb67ca86dad91d34cab06c4b6b1004695d4fbd8f9bdf"
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
