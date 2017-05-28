class Weather < Formula
  desc "A command line tool to retrieve local weather"
  homepage "https://github.com/TheHipbot/weather"
  url "https://github.com/TheHipbot/weather/raw/master/archive/weather-1.0.0.tar.gz"
  version "1.0.0"
  sha256 "b1c7ab25dfb4530a5e35aa690d79469de5ec419dd284f03868935c2417e1ee3a"

  depends_on "curl"

  bottle :unneeded

  def install
    bin.install "weather"
  end

  test do

    assert File.exist?("#{bin}/weather")
    output = "weather > testfile"
    system output
    assert File.exist?("testfile")
  end
end
