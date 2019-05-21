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
    sha256 "8db62baa6c15fdc5962dc17f025a9d18f08e8e526bba4e13617c6fe6782693d9" => :sierra
    sha256 "d275fa4cae0287bbf4388764e72e80d579e18fc68c83013bbe5fcfa81cd41336" => :x86_64_linux
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
