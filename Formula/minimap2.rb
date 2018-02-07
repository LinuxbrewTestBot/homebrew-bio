class Minimap2 < Formula
  desc "Fast pairwise aligner for genomic and spliced nucleotide sequences"
  homepage "https://github.com/lh3/minimap2"
  url "https://github.com/lh3/minimap2/releases/download/v2.8/minimap2-2.8.tar.bz2"
  sha256 "9899e548f4f4cbf2b9a5c3b20facb8dd583ee9f39be7ac0c3b0bdeb5ca3b0cc2"
  head "https://github.com/lh3/minimap2.git"
  # cite "https://arxiv.org/abs/1708.01492"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-bio"
    cellar :any
    sha256 "6575fc1f6baf16111482a0fb4c2c570a1009e112e7c8b1f8294d1b07b0a85ad5" => :sierra_or_later
    sha256 "535d17876edb95535a72848311415c47f9a42a08bec47391e123bc6feaf42f58" => :x86_64_linux
  end

  depends_on "zlib" unless OS.mac?

  def install
    system "make"
    bin.install "minimap2"
    man1.install "minimap2.1"
    pkgshare.install "python", "test"
  end

  test do
    assert_match "Usage", shell_output("#{bin}/minimap2 --help 2>&1")
  end
end
