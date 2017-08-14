# Documentation: https://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class VaspRaman < Formula
  desc "Raman off-resonant activity calculator using VASP as a back-end"
  homepage "https://github.com/raman-sc/VASP"
  url "https://github.com/raman-sc/VASP/blob/master/vasp_raman.py"
  version "0.6.0"
  sha256 "767751e182bb925d82ce1a5b499794e5d9b63383edd312b896157ed5a8a56047"

  depends_on "python"

  bottle :unneeded

  def install
    bin.install "vasp_raman.py"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test vasp-raman`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    assert File.exist?("#{bin}/vasp_raman.py")
  end
end
