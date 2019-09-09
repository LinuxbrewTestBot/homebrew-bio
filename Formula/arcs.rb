class Arcs < Formula
  # cite Yeo_2017: "https://doi.org/10.1093/bioinformatics/btx675"
  desc "Scaffold genome sequence assemblies using 10x Genomics data"
  homepage "https://github.com/bcgsc/arcs"
  url "https://github.com/bcgsc/arcs/releases/download/v1.1.0/arcs-1.1.0.tar.gz"
  sha256 "253bfcc7dd72cdbe21765d122a8503f22d997b4aa6ee29e9360dd1f66a2208ae"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-bio"
    cellar :any
    sha256 "025214bd4e6de45f1509d699259a4f5eb6e0d5cf0d1b81e2d9047f31b4753952" => :sierra
    sha256 "7d859bde63d4e711bb5be08925f7d247c490b8234ef578594feb90c42540e6c1" => :x86_64_linux
  end

  head do
    url "https://github.com/bcgsc/arcs.git"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  depends_on "boost" => :build
  depends_on "google-sparsehash" => :build
  if OS.mac?
    depends_on "gcc" # for openmp
  else
    depends_on "zlib"
  end

  fails_with :clang # needs openmp

  def install
    system "./autogen.sh" if build.head?
    system "./configure",
      "--disable-dependency-tracking",
      "--disable-silent-rules",
      "--prefix=#{prefix}",
      "--with-boost=#{Formula["boost"].opt_include}"
    system "make", "install"
  end

  test do
    assert_match "Usage", shell_output("#{bin}/arcs --help")
  end
end
