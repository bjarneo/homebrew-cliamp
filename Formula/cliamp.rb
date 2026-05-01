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
  version "1.40.0"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.40.0/cliamp-darwin-arm64"
      sha256 "4e38fd7ae5e1e6a8ea70396958e136ad30752a4c1425349c5f7f67994e0debd9"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.40.0/cliamp-darwin-amd64"
      sha256 "cc02d4faf994b1bbd7056a9bd97cfa0a533b61119216919ca72001a831961115"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.40.0/cliamp-linux-arm64"
      sha256 "39bd39b3fdd6909c8a811bee8e141ca53b85995297399f81ab907e9db7ad27e5"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.40.0/cliamp-linux-amd64"
      sha256 "15aee1a31107fb6e3e9ab3e0cffa7e7be2d546e86799c82b08d59a80e491e6ef"
    end
  end

  resource "icon" do
    url "https://raw.githubusercontent.com/bjarneo/cliamp/v1.40.0/Cliamp.png"
    sha256 "8b68d5696b993879188c401843472ee53335ad6710be11944d0fe43bbd8e4787"
  end

  resource "desktop" do
    url "https://raw.githubusercontent.com/bjarneo/cliamp/v1.40.0/cliamp.desktop"
    sha256 "3e2af63bbd6ddfbee31f2312a82d39d56bb332d209f2593450a4c93194386ebe"
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

    # Ship icon under pkgshare so it's always available; expose as
    # XDG icon + desktop entry on Linux for app-launcher integration.
    resource("icon").stage { pkgshare.install "Cliamp.png" => "cliamp.png" }

    on_linux do
      (share/"icons/hicolor/512x512/apps").install_symlink pkgshare/"cliamp.png"
      (share/"pixmaps").install_symlink pkgshare/"cliamp.png"
      resource("desktop").stage { (share/"applications").install "cliamp.desktop" }
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cliamp --version")
  end
end
