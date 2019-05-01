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
    sha256 "cc89d24d290da6e35955c5fe2e02c43ad98d55f248376708ba105b7515030759" => :sierra
    sha256 "57e7bf2395530c2ffdc8b88c8a31bf1c296f55e853f089766c222a97932929cb" => :x86_64_linux
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
