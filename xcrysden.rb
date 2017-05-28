class Xcrysden < Formula
  desc "XCrySDen is a crystalline and molecular structure visualisation program aiming at display of isosurfaces and contours, which can be superimposed on crystalline structures and interactively rotated and manipulated."
  homepage "http://www.xcrysden.org/"
  url "http://www.xcrysden.org/download/xcrysden-1.5.60-linux_x86_64-semishared.tar.gz"
  sha256 "24e78f984d1ddae6d53f360639202e13782684a186b8a07c83d0c82471698553"

  bottle :unneeded

  def install
    bin.install "xcrysden"
  end

  test do
    assert File.exist?("#{bin}/xcrysden")
  end
end
