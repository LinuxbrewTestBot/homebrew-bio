class Breseq < Formula
  # Deatherage_2014: "https://doi.org/10.1007/978-1-4939-0554-6_12"
  desc "Find mutations in microbes from short reads"
  homepage "http://barricklab.org/twiki/bin/view/Lab/ToolsBacterialGenomeResequencing"
  url "https://github.com/barricklab/breseq/releases/download/v0.33.2/breseq-0.33.2-Source.tar.gz"
  sha256 "ce1cb0c2893bdec4736e667214be47282d14bfb7d5fcefa097c342ca22e9082e"
  head "https://github.com/barricklab/breseq.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "488ac9146529595b84a64427c7f4409bc752e6a86f208b314454b26a4f4ff15e" => :sierra
    sha256 "e5d009f4fd6b8dcd4327b0fc43bd75254d61d0a99c6618c812449c493b2c600b" => :x86_64_linux
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "bowtie2"
  depends_on "gzip" unless OS.mac?
  depends_on "r"

  def install
    # Reduce memory usage for CircleCI.
    ENV["MAKEFLAGS"] = "-j8" if ENV["CIRCLECI"]

    system "./configure", "--prefix=#{prefix}", "--without-libunwind"
    system "make"
    system "make", "test"
    system "make", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/breseq --version 2>&1")
    assert_match "regardless", shell_output("#{bin}/breseq -h 2>&1", 255)
  end
end
