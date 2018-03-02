class Racon < Formula
  # cite Vaser_2017: "https://doi.org/10.1101/gr.214270.116"
  desc "Compute consensus sequence of a genome assembly of long uncorrected reads"
  homepage "https://github.com/isovic/racon"
  url "https://github.com/isovic/racon/releases/download/1.1.0/racon-v1.1.0.tar.gz"
  sha256 "8c183772d7e3314f1e50baf14395cecfae255c59a9061d4baef56f6863303022"
  head "https://github.com/isovic/racon.git"

  bottle do
    cellar :any_skip_relocation
    root_url "https://linuxbrew.bintray.com/bottles-bio"
    sha256 "d69babadc6d2dd8998930c477cb5fdae92cc01861aa4bca22a6983738f9499f5" => :sierra_or_later
    sha256 "2235f933003d0ab6be31d248eeb764bebeae1ee73ce877607e1865d136d7524b" => :x86_64_linux
  end

  needs :cxx11
  fails_with :clang # needs openmp

  depends_on "cmake" => :build
  if OS.mac?
    depends_on "gcc" # for openmp
  else
    depends_on "zlib"
  end

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make"
      system "make", "install"
    end
  end

  test do
    assert_match "usage", shell_output("#{bin}/racon --help")
  end
end
