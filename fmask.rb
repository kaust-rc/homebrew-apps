class Fmask < Formula
  desc "SW for automated clouds,cloud shadows,& snow masking for Landsat images"
  homepage "https://github.com/prs021/fmask"
  url "http://ftp-earth.bu.edu/public/zhuzhe/Fmask_Linux_3.2v/Fmask_pkg.zip"
  version "3.2"
  sha256 "f30351a6d8e545fbddb16bf5cc2eb3df586bd01733c7a3f9bb5c90092926d6eb"

  def linux_distro
    if File.exist?("/etc/debian_version")
      system "sudo", "apt-get", "libxt6",
                                "libxmu6"
    end
  end

  def install
    mv("readme.txt", "fmask_readme.txt")
    system "unzip", "MCRInstaller.zip"
    inreplace "installer_input.txt" do |s|
      s.gsub! "# destinationFolder=", "destinationFolder=#{prefix}"
      s.gsub! "# agreeToLicense=", "agreeToLicense=yes"
      s.gsub! "# outputFile=", "outputFile=/tmp/mathworks_fmask.log"
      s.gsub! "# mode=", "mode=silent"
    end
    system "./install", "-inputFile ./installer_input.txt"
    prefix.install ["Fmask"]
    prefix.install ["run_Fmask.sh"]
    (bin/"Fmask").write <<-EOS.undent
        #!/bin/bash -l
        export XAPPLRESDIR=#{prefix}/v81/X11/app-defaults
        export LD_LIBRARY_PATH=#{prefix}/v81/runtime/glnxa64:#{prefix}/v81/bin/glnxa64:#{prefix}/v81/sys/os/glnxa64:#{prefix}/v81/sys/java/jre/glnxa64/jre/lib/amd64/native_threads:#{prefix}/v81/sys/java/jre/glnxa64/jre/lib/amd64/server:#{prefix}/v81/sys/java/jre/glnxa64/jre/lib/amd64:$LD_LIBRARY_PATH
        if [[ "$1" =~ ^(-help|-h|--help)$ ]]; then
            echo "------"
            echo "Usage:"
            echo "------"
            echo "cd into the folder where Landsat bands and .MTL files downloaded and run Fmask by entering \\"Fmask\\" in the terminal."
            echo "There are four important tuning variables that you can play with:"
            echo "  1. \\"cldpix\\" is dilated number of pixels for cloud with default values of 3."
            echo "  2. \\"sdpix\\" is dilated number of pixels for cloud shadow with default values of 3."
            echo "  3. \\"snpix\\" is dilated number of pixels for snow with default values of 0."
            echo "  4. \\"cldprob\\" is the cloud probability threshold with default values of 22.5 (range from 0~100)."
            echo "If you want to use default values, \\"Fmask\\" is enough. If you want to customize your own parameters, you can use \\"Fmask cldpix sdpix snpix cldprob\\"."
            echo "For example \\"Fmask 3 3 0 22.5\\" in the terminal."
            echo "\n"
        else
            #redirecting the errors when running Fmask in a directory with no input files, leaving only the informative message for the user.
            exec "#{prefix}/Fmask" "$@" 2>/dev/null
        fi
    EOS
  end

  test do
    assert_predicate bin/"Fmask", :exist?
    assert_match "------\nUsage:\n------", shell_output("#{bin}/Fmask -help")
    assert_match "Fmask 3.2.1 beta version start ...
No L*MTL.txt header in the current folder!", shell_output("#{bin}/Fmask 2>/dev/null", 255)
  end
end
