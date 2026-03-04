class Cliamp < Formula
  desc "A retro terminal music player inspired by Winamp 2.x"
  homepage "https://github.com/bjarneo/cliamp"

  depends_on "ffmpeg" => :recommended
  depends_on "yt-dlp" => :recommended
  version "1.14.1"

  on_macos do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.14.1/cliamp-darwin-arm64"
      sha256 "48bc06e8ac85c15a79d98cbf1efa2414eb4ac1d9c5069a5198330e626e7a9100"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.14.1/cliamp-darwin-amd64"
      sha256 "61a544ede574e33976de4a22db2fad5bc668cd12000baf7349e730aa69279865"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.14.1/cliamp-linux-arm64"
      sha256 "1273b02be4b75ec2a6d1c6902dd05007087de721afe5dd58b543807002544c82"
    end
    on_intel do
      url "https://github.com/bjarneo/cliamp/releases/download/v1.14.1/cliamp-linux-amd64"
      sha256 "1e6b9eeca7f3d988963b1998044f6b34f91da0656c24342c2452594aa788e7c7"
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
