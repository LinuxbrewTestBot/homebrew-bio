class Flye < Formula
  # cite Kolmogorov_2018: "https://doi.org/10.1101/247148"
  desc "Fast and accurate de novo assembler for single molecule sequencing reads"
  homepage "https://github.com/fenderglass/Flye"
  url "https://github.com/fenderglass/Flye/archive/2.3.5.tar.gz"
  sha256 "d074055b1d8a8a91f0a0b28f98793441e82987ccb569a03d27db7d729a9fadcb"
  head "https://github.com/fenderglass/Flye.git"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-bio"
    cellar :any_skip_relocation
    sha256 "8b15356cd1b688d4b2655ad1fb255e145c77611e9a5b8be0cf3d04931b839ba0" => :sierra_or_later
    sha256 "0ce3b19c2d36587d0484738c757e24d17593ec4e7b68599291b3ae76ca2033df" => :x86_64_linux
  end

  needs :cxx11

  depends_on "python@2"

  def install
    system "python2", "setup.py", "install", "--prefix=#{prefix}"
  end

  test do
    assert_match "usage", shell_output("#{bin}/flye --help")
  end
end
