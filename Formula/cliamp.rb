class Cliamp < Formula
  desc "A retro terminal music player inspired by Winamp 2.x"
  homepage "https://github.com/bjarneo/cliamp"

  depends_on "ffmpeg" => :recommended
  depends_on "yt-dlp" => :recommended
  version "1.12.7"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.12.7/cliamp-darwin-arm64"
      sha256 "660daf09fca808be9ad0cc68985c1cd023e86b026f15b87761cdee87d7592277"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.12.7/cliamp-darwin-amd64"
      sha256 "639a6e276b9025101205c0b13e0ee69c16c83cce2a1661f8b865460838398478"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.12.7/cliamp-linux-arm64"
      sha256 "f30c76e4b2e5d8a1adfeb4f147bd75e69a52bac67a219db755f3e4b0c4e2d957"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.12.7/cliamp-linux-amd64"
      sha256 "73d338082d43a54df86c1c188be8e6684b3f4e67497653dd424e79c6b69f7cf5"
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
