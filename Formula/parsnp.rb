class Parsnp < Formula
  # cite Treangen_2014: "https://doi.org/10.1186/s13059-014-0524-x"
  desc "Microbial core genome alignment and SNP detection"
  homepage "https://github.com/marbl/parsnp"
  url "https://github.com/marbl/parsnp/archive/v1.2.tar.gz"
  sha256 "c2cbefcf961925c3368476420e28a63741376773f948094ed845a32291bda436"
  revision 3
  head "https://github.com/marbl/parsnp.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "7963dd05d1247f832b4c9d4dba0c6ab7ae268040171f0f3b6cfaece848744004" => :sierra
    sha256 "d77b446c1ba43b5fa2925d045da1c89f457cd9c8c193663e3467115d84fdf5ee" => :x86_64_linux
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "fasttree"
  depends_on "harvest-tools"
  depends_on "libmuscle"

  if OS.mac?
    depends_on "gcc"
  else
    depends_on "zlib"
  end

  fails_with :clang # needs openmp

  def install
    # remove binaries
    rm Dir["bin/*"]

    # https://github.com/marbl/parsnp/issues/52
    inreplace "src/parsnp.cpp", "1.0.1", version.to_s

    # we still build this, but runtime will link against libmuscle
    # see: https://github.com/brewsci/homebrew-bio/pull/362
    cd "muscle" do
      ENV.deparallelize
      system "./configure", "--prefix=#{Dir.pwd}"
      system "make", "install"
    end

    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}"

    # https://github.com/marbl/parsnp/issues/57
    libr = " -lMUSCLE-3.7"
    inreplace "src/Makefile", libr, ""
    inreplace "src/Makefile", "LIBS =", "LIBS =#{libr}"

    system "make"

    bin.install "src/parsnp"
    pkgshare.install "examples"
    doc.install "CITATION", "LICENSE", "README.md"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/parsnp -v 2>&1")
  end
end
