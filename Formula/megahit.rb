class Megahit < Formula
  # cite Li_2015: "https://doi.org/10.1093/bioinformatics/btv033"
  desc "Ultra-fast SMP/GPU succinct DBG metagenome assembly"
  homepage "https://github.com/voutcn/megahit"
  url "https://github.com/voutcn/megahit/archive/v1.1.3.tar.gz"
  sha256 "b6eefdee075aaf7a8f9090e2e8b08b770caff90aa43a255e0e220d82ce71c492"
  head "https://github.com/voutcn/megahit.git"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-bio"
    rebuild 1
    sha256 "a8a02e1e1ebb0bcf06c1e0f414f894b501e54f181c39c3cca3d8d5b40c3c8e81" => :sierra_or_later
    sha256 "1d65426e25bb7cb944fcbed2d083bf6ebfd667a9a872f54595be11100c0c478c" => :x86_64_linux
  end

  fails_with :clang # needs openmp

  depends_on "python@2"

  if OS.mac?
    depends_on "gcc" # for openmp
  else
    depends_on "zlib"
  end

  def install
    system "make"
    bin.install Dir["megahi*"]
    pkgshare.install "example"
  end

  test do
    outdir = "megahit.outdir"
    system "#{bin}/megahit", "--12", "#{pkgshare}/example/readsInterleaved1.fa.gz", "-o", outdir
    assert_predicate testpath/"#{outdir}/final.contigs.fa", :exist?
    assert_match outdir, File.read("#{outdir}/opts.txt")
  end
end
