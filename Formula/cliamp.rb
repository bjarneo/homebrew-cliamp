class Cliamp < Formula
  desc "A retro terminal music player inspired by Winamp 2.x"
  homepage "https://github.com/bjarneo/cliamp"

  depends_on "ffmpeg" => :recommended
  depends_on "yt-dlp" => :recommended
  version "1.13.2"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.13.2/cliamp-darwin-arm64"
      sha256 "01b81eb65d40791a79646bd9f41fc139c778aebc402597b6856a0db57da8d094"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.13.2/cliamp-darwin-amd64"
      sha256 "56ef264571c5cdcc81c6e6209c9d741a8372516433a1495e790f5f174f7449ca"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.13.2/cliamp-linux-arm64"
      sha256 "4dc1b7c0541bbae4c83d7d3469a446088120b95c4543dd284716013edb884dff"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.13.2/cliamp-linux-amd64"
      sha256 "f512cce5ec1a0d8af5508f89ac8ffb401849d3533d912dc689bcd986541c34d4"
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
