class Fastp < Formula
  # cite Chen_2018: "https://doi.org/10.1101/274100"
  desc "Ultrafast all-in-one FASTQ preprocessor"
  homepage "https://github.com/OpenGene/fastp"
  url "https://github.com/OpenGene/fastp/archive/v0.12.3.tar.gz"
  sha256 "e6f8ba5399290dd469d5da25caa9b97e40da8dc3066226faf692f4042c9d7055"
  head "https://github.com/OpenGene/fastp.git"

  depends_on "zlib" unless OS.mac?

  needs :cxx11

  def install
    system "make"
    bin.install "fastp"
    pkgshare.install "testdata"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/fastp --version 2>&1")
    system "#{bin}/fastp", "-i", pkgshare/"testdata/R1.fq", "-o", testpath/"out.fq"
    File.exist?("out.fq")
  end
end
