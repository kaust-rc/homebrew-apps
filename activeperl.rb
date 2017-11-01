class Activeperl < Formula
  desc "ActiveState's quality-assured Perl destribution"
  homepage "https://www.activestate.com/activeperl"
  url "https://downloads.activestate.com/ActivePerl/releases/5.26.0.2600/ActivePerl-5.26.0.2600-x86_64-linux-glibc-2.15-403863.tar.gz"
  version "5.26.0.2600"
  sha256 "df84fab28a3783e5d0d540e626a8e4b2b3000b9e9c16219736dac21c608b7ec4"

  depends_on "glibc"

  def install
    # install script fails if the install directory exists, so it has to be removed after brew creates it
    rm_rf(prefix.to_s, :secure=>true)
    system "./install.sh", "--license-accepted",
                           "--prefix=#{prefix}"
    man.install "#{prefix}/man"
  end

  test do
    assert_predicate bin/"perl", :exist?
    assert_match "Hello World!", shell_output("#{bin}/perl -e 'print \"Hello World!\n\"'")
  end
end
