class Unicycler < Formula
  # cite Wick_2017: "https://doi.org/10.1371/journal.pcbi.1005595"
  desc "Hybrid assembly pipeline for bacterial genomes"
  homepage "https://github.com/rrwick/Unicycler"
  url "https://github.com/rrwick/Unicycler/archive/v0.4.5.tar.gz"
  sha256 "67043656b31a4809f8fa8f73368580ba7658c8440b9f6d042c7f70b5eb6b19ae"
  head "https://github.com/rrwick/Unicycler/releases"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-bio"
    cellar :any_skip_relocation
    sha256 "4cac1f0f8dcaec6ec921ddb3ca78f41f2a93e39103eee4f00838d301ea3ceb08" => :sierra_or_later
    sha256 "58549e200c6d2eb13ff70a2d43138a0a9fa353dae388f95f43572681d991bae5" => :x86_64_linux
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
