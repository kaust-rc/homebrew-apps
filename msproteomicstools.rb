class Msproteomicstools < Formula
  desc "Useful tools for mass spectrometry applied to proteomics"
  homepage "http://msproteomicstools.hroest.ch/"
  url "https://github.com/msproteomicstools/msproteomicstools/archive/v0.5.0.tar.gz"
  version "0.5"
  sha256 "dbf0894c17824b61eb84882b03c7423dd614b5f4235fee76febdc8d2d426e407"

  depends_on "python3" => :build
  depends_on "openblas"
  depends_on "numpy"
  depends_on "libxml2"
  depends_on "libxslt"

  def install
    mkdir_p "#{lib}/python3.6/site-packages"
    ENV["PYTHONPATH"]= "#{lib}/python3.6/site-packages:$PYTHONPATH"
    system "python3", "setup.py", "install", "--prefix=#{prefix}"
  end

  test do
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
