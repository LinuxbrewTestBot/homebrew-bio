class Quast < Formula
  # cite Gurevich_2013: "https://doi.org/10.1093/bioinformatics/btt086"
  # cite Mikheenko_2015: "https://doi.org/10.1093/bioinformatics/btv697"
  # cite Mikheenko_2016: "https://doi.org/10.1093/bioinformatics/btw379"
  desc "QUAST: Quality Assessment Tool for Genome Assemblies"
  homepage "http://cab.spbu.ru/software/quast/"
  url "https://downloads.sourceforge.net/project/quast/quast-4.6.3.tar.gz"
  sha256 "c00ef637282207dcad05de9503c704bc6cc69eea4fb52f7802fd8566afa31c4e"
  head "https://github.com/ablab/quast.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-bio"
    prefix "/usr/local"
    cellar "/usr/local/Cellar"
    rebuild 1
    sha256 "b3db8f15c3473f17675249a0833ce918ebcdae26f8ab914d5e46858224d7a9bf" => :sierra
    sha256 "d3f9c9f0f9417cdb7cb7a33fabfc2cff4f261bae0fc73478573567b578192517" => :x86_64_linux
  end

  depends_on "matplotlib"

  stable do
    depends_on "e-mem"
  end

  def install
    # Remove the precompiled E-MEM binary.
    rm_f "quast_libs/MUMmer/e-mem-osx"
    prefix.install Dir["*"]
    bin.install_symlink "../quast.py", "../metaquast.py", "../icarus.py",
      "quast.py" => "quast", "metaquast.py" => "metaquast", "icarus.py" => "icarus"
    # Compile the bundled aligner so that `brew test quast` does not fail.
    system "#{bin}/quast", "--test"
  end

  test do
    system "#{bin}/quast", "--test"
  end
end
