class Weather < Formula
  desc "Command-line tool to retrieve local weather"
  homepage "https://github.com/TheHipbot/weather"
  url "https://github.com/TheHipbot/weather/raw/master/archive/weather-1.0.0.tar.gz"
  sha256 "b1c7ab25dfb4530a5e35aa690d79469de5ec419dd284f03868935c2417e1ee3a"

  bottle :unneeded

  depends_on "curl"

  def install
    bin.install "weather"
  end

  test do
    assert_predicate "#{bin}/weather", :exist?
    output = "weather > testfile"
    system output
    assert_predicate "testfile", :exist?
  end
end
