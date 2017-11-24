class Openms < Formula
  desc "Open-source software C++ library for LC-MS data management & analyses"
  homepage "http://www.openms.de"
  url "https://github.com/OpenMS/OpenMS/releases/download/Release2.2.0/OpenMS-2.2.0-src.tar.gz"
  version "2.2"
  sha256 "61e7d24890abb6f462e2f026efb0dc88b84639b228d96e919c8074d3b11d286e"

  depends_on "cmake" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "autoconf" => :build
  depends_on "boost"
  depends_on "glpk"
  depends_on "libsvm"
  depends_on "bzip2"
  depends_on "homebrew/science/coinmp"
  depends_on "eigen"

  def install
    mkdir("contrib-build") unless File.directory?("contrib-build")
    cd("contrib-build")
    system "cmake", "-DBUILD_TYPE=WILDMAGIC", "../contrib"
    system "cmake", "-DBUILD_TYPE=XERCESC", "../contrib"
    system "cmake", "-DBUILD_TYPE=SEQAN", "../contrib"
    mkdir("../OpenMS-build") unless File.directory?("OpenMS-build")
    cd("../OpenMS-build")
    system "cmake", "-DOPENMS_CONTRIB_LIBS=#{pwd}/../contrib-build", "-DBOOST_USE_STATIC=OFF", "--prefix=#{prefix}", "../", *std_cmake_args
    system "make", "-s"
  end

  test do
    system "FileInfo"
  end
end
