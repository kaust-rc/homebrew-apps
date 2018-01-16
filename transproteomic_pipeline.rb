class TransproteomicPipeline < Formula
  desc "TransProteomicPipeline: Collection of proteomics tools"
  homepage "http://tools.proteomecenter.org/wiki/index.php?title=Software:TPP"
  url "https://github.com/iracooke/tpp/archive/v4.8.0p9.tar.gz"
  version "4.8.0"
  sha256 "900365ccf0ba28a2e6c8401c809972cc33d28f1cfd4ca5624a8c37f24211492f"

  bottle do
    sha256 "f698520c827c0abb483f98f73ec6efdd277cb03e90d6ececd4159f0152e71d32" => :sierra
    sha256 "70ced32bd83184dd748702a9513ecf497c414bb351a632d6d1b21c85771a3918" => :el_capitan
    sha256 "bd472cae9ceee14834b7d12ac9c3fd142389c7cbb9b9eb182371d0d84e7987a8" => :yosemite
  end

  # doi "10.1007/978-1-60761-444-9_15"
  # tag "bioinformatics"

  depends_on "gd"
  depends_on "activeperl"
  depends_on "boost"

  def install
    cd "trans_proteomic_pipeline/src/" do
      rm_rf("Makefile.incl", :secure=>true)
      system "wget", "-q", "https://raw.githubusercontent.com/kaust-rc/homebrew-apps/transproteomic/archive/transproteomic_pipeline/Makefile.incl"
      File.open("Makefile.config.incl", "wb") do |f|
        f.write"TPP_ROOT=#{prefix}/\nTPP_WEB=#{prefix}/web/\nCGI_USERS_DIR=#{prefix}/cgi-bin/\nBOOST_INCL=-I#{HOMEBREW_PREFIX}/opt/boost/include/boost/\n"
        f.write"BOOST_FILESYSTEM_LIB=$(BOOST_LIBDIR)libboost_filesystem.a\nBOOST_IOSTREAMS_LIB= $(BOOST_LIBDIR)libboost_iostreams.a\n"
        f.write"BOOST_THREAD_LIB=$(BOOST_LIBDIR)libboost_thread-mt.a\nBOOST_REGEX_LIB= $(BOOST_LIBDIR)libboost_regex.a\nBOOST_SERIALIZATION_LIB= $(BOOST_LIBDIR)libboost_serialization.a\n"
        f.write"BOOST_SYSTEM_LIB= $(BOOST_LIBDIR)libboost_system.a\nBOOST_PROGRAM_OPTIONS_LIB= $(BOOST_LIBDIR)libboost_program_options.a\n"
        f.write"BOOST_LIBS=$(BOOST_FILESYSTEM_LIB) $(BOOST_SYSTEM_LIB) $(BOOST_IOSTREAMS_LIB) $(BOOST_THREAD_LIB) $(BOOST_Z_LIB) $(BOOST_REGEX_LIB) $(BOOST_PROGRAM_OPTIONS_LIB) $(BOOST_SERIALIZATION_LIB)\n"
        f.write"GD_LIB=#{HOMEBREW_PREFIX}/opt/gd/lib/libgd.a\nGD_INCL=#{HOMEBREW_PREFIX}/opt/gd/include/\n"
        f.write"PERL_BIN=#{HOMEBREW_PREFIX}/bin/perl\n"#SRC_ROOT=#{buildpath}/trans_proteomic_pipeline/src/"
      end

      # inreplace "../extern/ProteoWizard/Makefile.pwiz.incl", "$(PWIZ_LIB): $(BOOST_LIBS) $(OBJS_PWIZ)", "$(PWIZ_LIB): $(OBJS_PWIZ)"

      mkdir_p prefix/"web"
      mkdir_p prefix/"cgi-bin"
      mkdir_p prefix/"params"

      # Build fails with this set.  First failure is on building the gsl. There may be more
      ENV.deparallelize

      # If these are set TPP Makefiles will make incorrect inferences about the build system
      # Ideally this should be fixed in the TPP Makefiles but there are many of them and they have complex interdependencies
      ENV.delete("CC")
      ENV.delete("CXX")
      # ENV["CC"]="/usr/bin/gcc"
      # ENV["CXX"]="/usr/bin/g++"

      system "make", "SRC_ROOT=#{buildpath}/trans_proteomic_pipeline/src/"
      system "make", "install"
    end
  end

  test do
    system "#{bin}/ProphetModels.pl"
    system "#{bin}/ProteinProphet", "-h"
  end
end
