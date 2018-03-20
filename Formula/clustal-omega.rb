class ClustalOmega < Formula
  # cite Sievers_2011: "https://doi.org/10.1038/msb.2011.75"
  desc "Fast, scalable generation multiple sequence alignments"
  homepage "http://www.clustal.org/omega/"
  url "http://www.clustal.org/omega/clustal-omega-1.2.4.tar.gz"
  sha256 "8683d2286d663a46412c12a0c789e755e7fd77088fb3bc0342bb71667f05a3ee"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-bio"
    prefix "/usr/local"
    cellar :any
    rebuild 1
    sha256 "1c5ccf3162a96f0ab4d3cfe754608f8b0a6b9d626072db84eeb0ec6c534a3653" => :sierra
    sha256 "e063f2173b12c3ba3ba3367762f700ff7e1f57e8119088a9383a650a9a27facc" => :x86_64_linux
  end

  depends_on "argtable"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/clustalo --version")
  end
end
