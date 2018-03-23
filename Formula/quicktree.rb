class Quicktree < Formula
  desc "Phylogenetic neighbor-joining tree builder"
  homepage "https://www.sanger.ac.uk/science/tools/quicktree"
  url "https://github.com/khowe/quicktree/archive/v2.3.tar.gz"
  sha256 "3739f7962ce72c1d3c86ba0a3faa82cc60749f6d9f627c1aba3729b6c881dee4"
  head "https://github.com/khowe/quicktree.git"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-bio"
    cellar :any_skip_relocation
    sha256 "078298b9503e4f0c923b4a8d07be1712e40db974f7d46e144c570bc79a392722" => :sierra_or_later
    sha256 "9a05196897f1f10455db8756847927679710b344ecdd525f0f8780dee16a3e02" => :x86_64_linux
  end

  def install
    system "make"
    bin.install "quicktree"
  end

  test do
    assert_match "UPGMA", shell_output("#{bin}/quicktree -h 2>&1")
    assert_match version.to_s, shell_output("#{bin}/quicktree -v 2>&1")
  end
end
