class SnpDists < Formula
  desc "Pairwise SNP distance matrix from a FASTA sequence alignment"
  homepage "https://github.com/tseemann/snp-dists"
  url "https://github.com/tseemann/snp-dists/archive/v0.2.tar.gz"
  sha256 "3deb6feb5d2b8c3588059fdfa14a94440957fe31f9da4f9c0c7e72113f2f52fc"
  head "https://github.com/tseemann/snp-dists.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "6f98a2554188f4aa3d8433133d9d3dc192c86e6a61600fe7e3fc80059555694c" => :sierra
    sha256 "79b93f15299b2ce98f9fd017130bf1f320f1500fd077036b5e32419cd38d0e74" => :x86_64_linux
  end

  depends_on "zlib" unless OS.mac?

  def install
    exe = "snp-dists"
    system "make", exe
    bin.install exe
    pkgshare.install "test"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/snp-dists -v")
    assert_match "matrix", shell_output("#{bin}/snp-dists -h")
    assert_match ",seq1,seq2,seq3,seq4", shell_output("#{bin}/snp-dists -q -b -c #{pkgshare}/test/good.aln")
  end
end
