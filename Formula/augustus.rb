class Augustus < Formula
  desc "Predict genes in eukaryotic genomic sequences"
  homepage "http://bioinf.uni-greifswald.de/augustus/"
  url "http://bioinf.uni-greifswald.de/augustus/binaries/augustus-3.3.tar.gz"
  sha256 "b5eb811a4c33a2cc3bbd16355e19d530eeac6d1ac923e59f48d7a79f396234ee"
  revision 2

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-bio"
    prefix "/usr/local"
    cellar "/usr/local/Cellar"
    sha256 "b041267ab0aec76fcabb2079dca6e44e4f55d7ff6ffa04d7eb3572b08cfcbb90" => :sierra_or_later
    sha256 "3829eb5b85d2f5b47c2f8ca751a00c9b8f4a0d5b0ffd9ded9b555cb3f9acc12a" => :x86_64_linux
  end

  depends_on "bamtools"
  depends_on "boost"

  def install
    # Fix error: api/BamReader.h: No such file or directory
    inreplace "auxprogs/bam2hints/Makefile",
      "INCLUDES = /usr/include/bamtools",
      "INCLUDES = #{Formula["bamtools"].include/"bamtools"}"
    inreplace "auxprogs/filterBam/src/Makefile",
      "BAMTOOLS = /usr/include/bamtools",
      "BAMTOOLS= #{Formula["bamtools"].include/"bamtools"}"

    # Prevent symlinking into /usr/local/bin/
    inreplace "Makefile", %r{ln -sf.*/usr/local/bin/}, "#ln -sf"

    # Compile executables for macOS. Tarball ships with executables for Linux.
    system "make", "clean"
    system "make"

    system "make", "install", "INSTALLDIR=#{prefix}"
    bin.env_script_all_files libexec/"bin", :AUGUSTUS_CONFIG_PATH => prefix/"config"
  end

  test do
    (testpath/"test.fasta").write <<~EOS
      >U00096.2:1-70
      AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC
    EOS
    cmd = "#{bin}/augustus --species=human test.fasta"
    assert_match "Predicted genes", shell_output(cmd)
  end
end
