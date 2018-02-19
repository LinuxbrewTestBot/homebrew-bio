class Fwdpp < Formula
  # cite "https://doi.org/10.1534/genetics.114.165019"
  desc "C++ template library for forward-time population genetic simulations"
  homepage "https://molpopgen.github.io/fwdpp/"
  url "https://github.com/molpopgen/fwdpp/archive/0.5.7.tar.gz"
  sha256 "e038462b0522f4b5aa135211222ce354df4c81a89122240b9eaacc72b62a0ceb"
  revision 2
  head "https://github.com/molpopgen/fwdpp.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-bio"
    prefix "/usr/local"
    cellar :any
    sha256 "e24702907b9391dc74648cd0afa66bb471085b8ca7f816d76820a5d50e5069ed" => :sierra
    sha256 "f5a7a5054efbdea1096c655f4d44f265886721bee0c4e1ddf027a559a26fc26b" => :x86_64_linux
  end

  # build fails on Yosemite
  depends_on :macos => :el_capitan

  depends_on "boost"
  depends_on "gsl"
  depends_on "libsequence"

  def install
    # Reduce memory usage for Circle CI.
    ENV["MAKEFLAGS"] = "-j16" if ENV["CIRCLECI"]

    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
    pkgshare.install "examples", "testsuite/unit"
  end

  test do
    assert_equal version, shell_output("#{bin}/fwdppConfig --version")
  end
end
