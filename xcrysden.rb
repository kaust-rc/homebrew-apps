class Xcrysden < Formula
  desc "Crystalline and molecular structure visualisation program."
  homepage "http://www.xcrysden.org/"
  url "http://www.xcrysden.org/download/xcrysden-1.5.60-linux_x86_64-semishared.tar.gz"
  sha256 "24e78f984d1ddae6d53f360639202e13782684a186b8a07c83d0c82471698553"

  bottle :unneeded

  depends_on "tcl-tk"
  depends_on "fftw"

  def install
    prefix.install Dir["*"]
    (bin/"xcrysden").write <<-EOS.undent
        #!/bin/bash -l
         "#{prefix}/xcrysden"
    EOS
  end

  test do
    assert File.exist?("#{bin}/xcrysden")
  end
end
