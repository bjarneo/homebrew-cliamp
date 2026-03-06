class Cliamp < Formula
  desc "A retro terminal music player inspired by Winamp 2.x"
  homepage "https://github.com/bjarneo/cliamp"

  depends_on "ffmpeg" => :recommended
  depends_on "yt-dlp" => :recommended
  version "1.17.8"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.17.8/cliamp-darwin-arm64"
      sha256 "ca37ec636e436e23c3092936cb92904bb30da0fb4fe477711b247dce3cf48f1c"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.17.8/cliamp-darwin-amd64"
      sha256 "bc937fa2d8fb96b41a45e24ca4198416159bb742a0fe66a11253838d0900c893"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.17.8/cliamp-linux-arm64"
      sha256 "089325f7df30775ba292bd4e7b7f0946a7f52669de8956442f0d1ab21f66e2bc"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.17.8/cliamp-linux-amd64"
      sha256 "c9629ef167b0f21b5f3e540dcf996374650ac6b6e9b6722ccd101cd36c7c1307"
    end
  end

  def install
    binary = Dir["cliamp-*"].first
    bin.install binary => "cliamp"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cliamp --version")
  end
end
