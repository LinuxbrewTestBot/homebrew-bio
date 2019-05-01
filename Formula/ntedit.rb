class Ntedit < Formula
  # cite Warren_2019: "https://doi.org/10.1101/565374"
  desc "Scalable genome assembly polishing"
  homepage "https://github.com/bcgsc/ntEdit"
  url "https://github.com/bcgsc/ntEdit/archive/v1.2.1.tar.gz"
  sha256 "0ed34798bfa5c81196175087a28c26496aaa853709b6e3514ab29145938e45ef"
  head "https://github.com/bcgsc/ntEdit.git"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-bio"
    cellar :any
    sha256 "32c0f2249a180ae79973e5439f81927000f84e24dda62f7b2c912eb047d603f8" => :sierra
    sha256 "508ab570089b9a3b9d2ba938c1a1d61d81132bfea55a81af01dceb0cc21dde6e" => :x86_64_linux
  end

  if OS.mac?
    depends_on "gcc" # for openmp
  else
    depends_on "zlib"
  end

  fails_with :clang # needs openmp

  def install
    system "make"
    bin.install "ntedit"
  end

  test do
    assert_match "Options", shell_output("#{bin}/ntedit --help 2>&1")
  end
end
