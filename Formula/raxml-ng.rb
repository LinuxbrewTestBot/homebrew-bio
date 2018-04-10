class RaxmlNg < Formula
  desc "RAxML Next Generation: faster, easier-to-use and more flexible"
  homepage "https://sco.h-its.org/exelixis/web/software/raxml/"
  url "https://github.com/amkozlov/raxml-ng.git",
    :tag => "0.5.1",
    :revision => "8a3d6af12fbff60239744595631a468275d5a02a"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "cmake" => :build
  depends_on "libtool" => :build
  unless OS.mac?
    depends_on "bison" => :build
    depends_on "flex" => :build
    depends_on "open-mpi" => :recommended
  end

  resource "example" do
    url "https://sco.h-its.org/exelixis/resource/download/hands-on/dna.phy"
    sha256 "c2adc42823313831b97af76b3b1503b84573f10d9d0d563be5815cde0effe0c2"
  end

  def install
    # Build release binaries
    inreplace "CMakeLists.txt", "set (CMAKE_BUILD_TYPE DEBUG)", ""
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "libpll"
      system "make"
      if build.with? "open-mpi"
        system "cmake", "..", *std_cmake_args, "-DUSE_MPI=ON"
        system "make", "libpll"
        system "make"
      end
    end
    bin.install Dir["bin/raxml-ng*"]
  end

  test do
    testpath.install resource("example")
    args = %w[--all --msa dna.phy --model GTR+G --bs-trees 100 --tree pars{10} --force --threads 2]
    system "#{bin}/raxml-ng", *args
  end
end
