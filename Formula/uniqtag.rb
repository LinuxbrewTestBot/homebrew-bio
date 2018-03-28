class Uniqtag < Formula
  # Jackman_2014: "http://dx.doi.org/10.1101/007583"
  desc "Abbreviate strings to short unique identifiers"
  homepage "https://github.com/sjackman/uniqtag"
  url "https://github.com/sjackman/uniqtag/archive/1.0.tar.gz"
  sha256 "8ff0dd850c15ff3468707ae38a171deb6518866a699964a1aeeec9c90ded7313"
  head "https://github.com/sjackman/uniqtag.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-bio"
    prefix "/usr/local"
    cellar :any_skip_relocation
    sha256 "7579221b25d406cab550687a6d083683f2f4d1060372c5901aec58ca20adf1fc" => :sierra
    sha256 "11701749a7b1189fb21658a8f959be0942027ff91162742fb11cdabf3b6a1b5b" => :x86_64_linux
  end

  depends_on "ruby" unless OS.mac?

  def install
    system "make", "install", "prefix=#{prefix}"
    doc.install "README.md"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/uniqtag --version 2>&1")
  end
end
