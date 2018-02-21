class Mothur < Formula
  # cite "https://doi.org/10.1128/AEM.01541-09"
  desc "16s analysis software"
  homepage "https://www.mothur.org/"
  url "https://github.com/mothur/mothur/archive/v1.39.5.tar.gz"
  sha256 "9f1cd691e9631a2ab7647b19eb59cd21ea643f29b22cde73d7f343372dfee342"
  revision 3
  head "https://github.com/mothur/mothur.git"

  depends_on "boost"
  depends_on "readline" unless OS.mac?

  def install
    # Reduce memory usage for Circle CI.
    ENV["MAKEFLAGS"] = "-j8" if ENV["CIRCLECI"]

    boost = Formula["boost"]
    inreplace "Makefile", '"\"Enter_your_boost_library_path_here\""', boost.opt_lib
    inreplace "Makefile", '"\"Enter_your_boost_include_path_here\""', boost.opt_include
    system "make"
    bin.install "mothur", "uchime"
  end

  test do
    system "#{bin}/mothur", "-h"
    system "#{bin}/uchime", "--help"
  end
end
