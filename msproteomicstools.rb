class Msproteomicstools < Formula
  desc "Useful tools for mass spectrometry applied to proteomics"
  homepage "http://msproteomicstools.hroest.ch/"
  url "https://github.com/msproteomicstools/msproteomicstools/archive/v0.5.0.tar.gz"
  version "0.5"
  sha256 "dbf0894c17824b61eb84882b03c7423dd614b5f4235fee76febdc8d2d426e407"

  depends_on "python" => :build
  depends_on "openblas"
  depends_on "libxml2"
  depends_on "libxslt"

  def install
    system "pip2", "install", "cython"
    system "pip2", "install", "numpy"
    mkdir_p libexec/"lib/python2.7/site-packages"
    cp_r("test", prefix.to_s)
    system "python2", *Language::Python.setup_install_args(libexec)
    lib.install Dir[libexec/"lib/*"]
    ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python2.7/site-packages"
  end

  test do
    system "python2", prefix/"test/test_import.py"
  end
end
