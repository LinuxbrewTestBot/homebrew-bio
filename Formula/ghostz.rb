class Ghostz < Formula
  # cite Suzuki_2014: "https://doi.org/10.1093/bioinformatics/btu780"
  desc "High-speed remote homologue sequence search tool"
  homepage "https://www.bi.cs.titech.ac.jp/ghostz/"
  url "https://www.bi.cs.titech.ac.jp/ghostz/releases/ghostz-1.0.2.tar.gz"
  sha256 "3e896563ab49ef620babfb7de7022d678dee2413d34b780d295eff8b984b9902"

  depends_on "gcc" # for openmp

  # MacOS can't build binary; CI times out in gcc install
  # https://github.com/brewsci/homebrew-bio/pull/794
  depends_on :linux

  fails_with :clang # needs openmp

  def install
    system "make"
    bin.install "ghostz"
    pkgshare.install Dir["test/*.fa"]
  end

  test do
    # Returns 1 not 0 | https://github.com/akiyamalab/ghostz/issues/3
    assert_match version.to_s, shell_output("#{bin}/ghostz -h 2>&1", 1)
  end
end
