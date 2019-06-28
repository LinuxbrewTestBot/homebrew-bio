class Flye < Formula
  # cite Kolmogorov_2018: "https://doi.org/10.1101/247148"
  desc "Fast and accurate de novo assembler for single molecule sequencing reads"
  homepage "https://github.com/fenderglass/Flye"
  url "https://github.com/fenderglass/Flye/archive/2.4.2.tar.gz"
  sha256 "5b74d4463b860c9e1614ef655ab6f6f3a5e84a7a4d33faf3b29c7696b542c51a"
  head "https://github.com/fenderglass/Flye.git", :branch => "flye"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "27cbdd70df127dd3aa91c10ca07cc5fc45f84ab662d40824fc5c214657d3184e" => :sierra
    sha256 "9fd0d53b7818190a4220f45a47166baf1eb310cae22d3725361bc0e028fbd519" => :x86_64_linux
  end

  depends_on "python@2"

  def install
    system "python2", "setup.py", "install", "--prefix=#{prefix}"
  end

  test do
    assert_match "usage", shell_output("#{bin}/flye --help")
  end
end
