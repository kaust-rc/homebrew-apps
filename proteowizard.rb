class Proteowizard < Formula
  desc "Modular cross-platform tools for easy proteomics data analysis"
  homepage "https://proteowizard.sourceforge.io/"
  url "https://raw.githubusercontent.com/kaust-rc/homebrew-apps/master/archive/pwiz-bin-linux-x86_64-gcc48-release-3_0_11579.tar.bz2"
  sha256 "a1236512070c4fd7818df9a1a49d5114a188030a45402b9b7a66a893b5aa16a9"

  def install
    prefix.install "quantitation_1.xsd", "quantitation_2.xsd", "unimod_2.xsd"
    bin.install "chainsaw", "idcat", "idconvert", "msaccess", "msbenchmark", "mscat", "msconvert", "msdiff", "msdir", "msistats"
    bin.install "mspicture", "peakaboo", "pepcat", "pepsum", "qtofpeakpicker", "sldout", "txt2mzml"
  end

  test do
    assert_predicate bin/"chainsaw", :exist?
    assert_predicate bin/"idcat", :exist?
    assert_predicate bin/"idconvert", :exist?
    assert_predicate bin/"msaccess", :exist?
    assert_predicate bin/"msbenchmark", :exist?
    assert_predicate bin/"mscat", :exist?
    assert_predicate bin/"msconvert", :exist?
    assert_predicate bin/"msdiff", :exist?
    assert_predicate bin/"msdir", :exist?
    assert_predicate bin/"msistats", :exist?
    assert_predicate bin/"mspicture", :exist?
    assert_predicate bin/"peakaboo", :exist?
    assert_predicate bin/"pepcat", :exist?
    assert_predicate bin/"pepsum", :exist?
    assert_predicate bin/"qtofpeakpicker", :exist?
    assert_predicate bin/"sldout", :exist?
    assert_predicate bin/"txt2mzml", :exist?
  end
end
