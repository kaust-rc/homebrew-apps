# Documentation: http://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Weather < Formula
  desc "A command line tool to retrieve local weather"
  homepage "https://github.com/TheHipbot/weather"
  url "https://github.com/TheHipbot/weather/raw/master/archive/weather-1.0.0.tar.gz"
  version "1.0.0"
  sha256 "b1c7ab25dfb4530a5e35aa690d79469de5ec419dd284f03868935c2417e1ee3a"

  # depends_on "cmake" => :build
  depends_on "curl"

  bottle :unneeded
  
  def install
    
    bin.install "weather"
    # ENV.deparallelize  # if your formula fails when building in parallel

    # Remove unrecognized options if warned by configure
    #system "./configure", "--disable-debug",
    #                      "--disable-dependency-tracking",
     #                     "--disable-silent-rules",
      #                    "--prefix=#{prefix}"
    # system "cmake", ".", *std_cmake_args
    #system "make", "install" # if this fails, try separate make/make install steps
  end

  test do
    assert File.exist?("#{bin}/weather")
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test weather`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
   # system "false"
  end
end
