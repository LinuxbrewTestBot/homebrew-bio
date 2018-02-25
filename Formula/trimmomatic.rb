class Trimmomatic < Formula
  # cite Bolger_2014: "https://doi.org/10.1093/bioinformatics/btu170"
  desc "Flexible read trimming tool for Illumina data"
  homepage "http://www.usadellab.org/cms/?page=trimmomatic"
  url "http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/Trimmomatic-0.36.zip"
  sha256 "4846c42347b663b9d6d3a8cef30da2aec89fc718bf291392c58e5afcea9f70fe"

  depends_on :java

  def install
    cmd = "trimmomatic"
    jar = "#{cmd}-0.36.jar"
    libexec.install jar
    bin.write_jar_script libexec/jar, cmd
    pkgshare.install "adapters"
  end

  def caveats
    <<~EOS
      FASTA file of adapter sequences are located here:
      #{pkgshare}/adapters
    EOS
  end

  test do
    assert_match "trimmer", shell_output("#{bin}/trimmomatic 2>&1", 1)
  end
end
