class Ale < Formula
  # cite Clark_2013: "https://doi.org/10.1093/bioinformatics/bts723"
  desc "Assembly Likelihood Estimator"
  homepage "https://github.com/sc932/ALE"
  url "https://github.com/sc932/ALE/archive/20180904.tar.gz"
  version "0.0.20180904"
  sha256 "123457834c173f10710a0b4c2fcefd8c6fa62af11f6ad311f199c242c49e8f68"
  head "https://github.com/sc932/ALE.git"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-bio"
    cellar :any_skip_relocation
    sha256 "0b4ca1437ab82ddc666eb666abd71839ae716b3fd8d3c0599cd2e7b77c8c53df" => :sierra_or_later
    sha256 "c94cba3e6b7ee8892c110021bb2bb5ffe351383fee795e0095ea3c9099b408bb" => :x86_64_linux
  end

  depends_on "zlib" unless OS.mac?

  def install
    cd "src" do
      system "make"
      bin.install "ALE", "GCcompFinder", "readFileSplitter", "synthReadGen"
    end
  end

  test do
    assert_match "Usage", shell_output("#{bin}/ALE --help")
    assert_match "Usage", shell_output("#{bin}/GCcompFinder --help")
    assert_match "Usage", shell_output("#{bin}/readFileSplitter")
    assert_match "Usage", shell_output("#{bin}/synthReadGen --help")
  end
end
