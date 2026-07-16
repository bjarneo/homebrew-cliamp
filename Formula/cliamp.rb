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
  version "1.57.2"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.57.2/cliamp-darwin-arm64"
      sha256 "97dbe7db2059fe62ae55c8a354702cf26b5636a780aaf6a5dab9f9e216493b4a"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.57.2/cliamp-darwin-amd64"
      sha256 "b0e2bae0e4e975f70e557b8a9a91e15d00d5a84058db0adbe02ff7fab2f8f01a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.57.2/cliamp-linux-arm64"
      sha256 "7c00f1416835322875018463a4b197d11f4f418fc3e6abc6e47ad4a81495b8d2"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.57.2/cliamp-linux-amd64"
      sha256 "a595143c3fc4ce9c243e794f9df1f30501c948cc38d0a01ec3ce888e53e1a5c7"
    end
  end

  resource "icon" do
    url "https://raw.githubusercontent.com/bjarneo/cliamp/v1.57.2/Cliamp.png"
    sha256 "8b68d5696b993879188c401843472ee53335ad6710be11944d0fe43bbd8e4787"
  end

  resource "desktop" do
    url "https://raw.githubusercontent.com/bjarneo/cliamp/v1.57.2/cliamp.desktop"
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
