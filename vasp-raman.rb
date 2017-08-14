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
    chmod 0755, "#{bin}/vasp_raman.py"
  end

  test do
    # We'd need VASP installed to perform a real test, so let's just check the file exists
    assert File.exist?("#{bin}/vasp_raman.py")
    assert File.executable?("#{bin}/vasp_raman.py")
  end
end
