class Proteowizard < Formula
  desc "Set of modular cross-platform tools to facilitate proteomics data analysis"
  homepage "https://proteowizard.sourceforge.net/index.shtml"
  url "file:///home/hassanah/Downloads/pwiz-bin-linux-x86_64-gcc48-release-3_0_11579.tar.bz2"
  version "3.0.11579"
  sha256 "a1236512070c4fd7818df9a1a49d5114a188030a45402b9b7a66a893b5aa16a9"

  def install
    bin.install Dir["*"]
  end

  test do
    assert_predicate bin/"chainsaw", :exist?
  end
end
