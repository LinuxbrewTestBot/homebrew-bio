class DshBio < Formula
  desc "Tools for BED, FASTA, FASTQ, GFA1/2, GFF3, and VCF files"
  homepage "https://github.com/heuermh/dishevelled-bio"
  url "https://search.maven.org/remotecontent?filepath=org/dishevelled/dsh-bio-tools/1.0/dsh-bio-tools-1.0-bin.tar.gz"
  sha256 "db92ebf79d0c6739d8b834a94db6ac22db055e2f427c7a5de5382adc54f884c9"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-bio"
    prefix "/usr/local"
    cellar :any_skip_relocation
    sha256 "376b57a48d47331794715c0e598a4c1869f5c5e1625561f92dfce8c6819c3727" => :sierra
    sha256 "8dc9d010f5df5335d4d3fa2755cd9d0a33e86d871ae5c99aeb0a1d62669f37e1" => :x86_64_linux
  end

  depends_on :java => "1.8+"

  def install
    rm Dir["bin/*.bat"] # Remove all windows files
    libexec.install Dir["*"]
    bin.write_exec_script Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match "usage", shell_output("#{bin}/dsh-bio --help")
  end
end
