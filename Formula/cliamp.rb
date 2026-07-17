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
  version "1.60.1"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.60.1/cliamp-darwin-arm64"
      sha256 "7d63865df24052f719b82280086a24092c097f512410d7dbe80c5b4015043edb"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.60.1/cliamp-darwin-amd64"
      sha256 "3afb692291c37ff5281c336de0484bf4440605462af0ad9b038983b3e33c1556"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.60.1/cliamp-linux-arm64"
      sha256 "572d99a7ec2fa5a4ef3e51a47f43665f7739cd4f0bb0092c50010313457edeec"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.60.1/cliamp-linux-amd64"
      sha256 "0452e1951991869e1e840a393c16026f6088353575ca7cb42fde0b860b9fde48"
    end
  end

  resource "icon" do
    url "https://raw.githubusercontent.com/bjarneo/cliamp/v1.60.1/Cliamp.png"
    sha256 "8b68d5696b993879188c401843472ee53335ad6710be11944d0fe43bbd8e4787"
  end

  resource "desktop" do
    url "https://raw.githubusercontent.com/bjarneo/cliamp/v1.60.1/cliamp.desktop"
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
