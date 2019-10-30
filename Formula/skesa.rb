class Skesa < Formula
  # cite Souvorov_2018: "https://doi.org/10.1186/s13059-018-1540-z"
  desc "Strategic Kmer Extension for Scrupulous Assemblies"
  homepage "https://github.com/ncbi/SKESA"
  url "https://github.com/ncbi/SKESA/archive/v2.3.0.tar.gz"
  sha256 "13832e41b69a94d9f64dee7685b4d05f2e94f807ad819afa8d4cd78cee54879d"
  revision 1

  bottle do
    cellar :any
    sha256 "9ee73700c7bc3dbd9dda4fea03cec55473454bce6fd1f74b13011c03a5dbf632" => :mojave
    sha256 "993665370cc1ea441faffbc0af70d6933161043acb64c9dc2144f909d19de1a3" => :x86_64_linux
  end

  depends_on "boost"

  uses_from_macos "zlib"

  def install
    makefile = "Makefile.nongs"

    # https://github.com/ncbi/SKESA/issues/6
    if OS.mac?
      inreplace makefile, "-Wl,-Bstatic", ""
      inreplace makefile, "-Wl,-Bdynamic -lrt", ""
    end

    system "make", "-f", makefile, "BOOST_PATH=#{Formula["boost"].opt_prefix}"
    bin.install "skesa"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/skesa --version 2>&1")
  end
end
