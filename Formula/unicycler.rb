class Unicycler < Formula
  # cite Wick_2017: "https://doi.org/10.1371/journal.pcbi.1005595"
  desc "Hybrid assembly pipeline for bacterial genomes"
  homepage "https://github.com/rrwick/Unicycler"
  url "https://github.com/rrwick/Unicycler/archive/v0.4.5.tar.gz"
  sha256 "67043656b31a4809f8fa8f73368580ba7658c8440b9f6d042c7f70b5eb6b19ae"
  head "https://github.com/rrwick/Unicycler/releases"

  bottle do
    prefix "/usr/local"
    cellar :any
    sha256 "371519d2cd3ab0aab5bc6a093446f5d5b185da90dbf3404bc2056aa2af9ae512" => :sierra
    sha256 "c7d704473906bd1e2ca56561d741dfae726f50248417d9c93f8586e74076cc5a" => :x86_64_linux
  end

  needs :cxx14

  depends_on "blast"
  depends_on "bowtie2"
  depends_on "pilon"
  depends_on "python"
  depends_on "racon"
  depends_on "samtools"
  depends_on "spades"

  def install
    system "python3", "setup.py", "install", "--prefix=#{prefix}"
  end

  test do
    assert_match "usage", shell_output("#{bin}/unicycler --help")
  end
end
