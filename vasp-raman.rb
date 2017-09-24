class VaspRaman < Formula
  desc "Raman off-resonant activity calculator using VASP as a back-end"
  homepage "https://github.com/raman-sc/VASP"
  url "https://raw.githubusercontent.com/raman-sc/VASP/master/vasp_raman.py"
  version "0.6.0"
  sha256 "00b9e15a2a277299ae1093915bcd9cf6f4f70d26f47acd289055502bd1efcd0c"

  depends_on "python"

  bottle :unneeded

  def install
    bin.install "vasp_raman.py"
  end

  test do
    # We'd need VASP installed to perform a real test, so let's just check the file exists
    assert File.executable?("#{bin}/vasp_raman.py")
    assert_match "Usage: vasp_raman.py [options]", shell_output("#{bin}/vasp_raman.py", 1)
  end
end
