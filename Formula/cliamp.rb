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
  version "1.63.2"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.63.2/cliamp-darwin-arm64"
      sha256 "e9786bcedb5c284a6c15b8d472b846e67e321ab9e95b688ef999de24baec6074"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.63.2/cliamp-darwin-amd64"
      sha256 "e8595ba960be284cf6ab21a3dd34537a8ddca4fca4fd253f057e02379f608276"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.63.2/cliamp-linux-arm64"
      sha256 "3be4ebe8806d2432b58afedd0fbdcb9522266b0204ab6cddb7f519f6ee33a8aa"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.63.2/cliamp-linux-amd64"
      sha256 "b066832c84cb9dffcb126252dedb55a0ebcd13cbac95bbff103b111b88ce17c9"
    end
  end

  resource "icon" do
    url "https://raw.githubusercontent.com/bjarneo/cliamp/v1.63.2/Cliamp.png"
    sha256 "8b68d5696b993879188c401843472ee53335ad6710be11944d0fe43bbd8e4787"
  end

  resource "desktop" do
    url "https://raw.githubusercontent.com/bjarneo/cliamp/v1.63.2/cliamp.desktop"
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
