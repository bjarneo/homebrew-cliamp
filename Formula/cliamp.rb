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
  version "1.50.0"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.50.0/cliamp-darwin-arm64"
      sha256 "ef73cd1f2c30794036864f43dc5f14a9abab6e2aae95a30f7f9ac1e95aecde5f"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.50.0/cliamp-darwin-amd64"
      sha256 "3226f9d486a6fe25d61359eae7988904e2b3443a34a425379f50034a2eda8712"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.50.0/cliamp-linux-arm64"
      sha256 "bbaca6cd2d28ab4b3f687ef9b4b20bb7eb71ec86944abeea640cf47d3ff0ceeb"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.50.0/cliamp-linux-amd64"
      sha256 "490a210d3893a306d11d173432ec0aa2151cbded41962c58552e4489e812ce39"
    end
  end

  resource "icon" do
    url "https://raw.githubusercontent.com/bjarneo/cliamp/v1.50.0/Cliamp.png"
    sha256 "8b68d5696b993879188c401843472ee53335ad6710be11944d0fe43bbd8e4787"
  end

  resource "desktop" do
    url "https://raw.githubusercontent.com/bjarneo/cliamp/v1.50.0/cliamp.desktop"
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
