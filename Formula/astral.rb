class Astral < Formula
  # cite Zhang_2017: "https://doi.org/10.1007/978-3-319-67979-2_4"
  desc "Estimate species tree given set of unrooted gene trees"
  homepage "https://github.com/smirarab/ASTRAL"
  url "https://github.com/smirarab/ASTRAL/archive/v5.6.3.tar.gz"
  sha256 "2bd83af2ab1ef51999e3bb335763bfa289dc3288f95654442820c0d905a50c83"
  head "https://github.com/smirarab/ASTRAL.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "a172372a26eca9157cca20bf68031929ab40e7af9acdc25f76599dae7e26b974" => :mojave
    sha256 "da19526c494d0846522a4e095766b3e9996cf01c0aa7e5c73db604167f0553bc" => :x86_64_linux
  end

  depends_on :java

  def install
    inreplace "make.sh" do |s|
      s.gsub! /version=.*/, "version=#{version}"
      s.gsub! /^zip/, "echo" # no need to zip anything
    end
    system "./make.sh"
    libexec.install "lib", "astral.#{version}.jar"
    pkgshare.install "main/test_data"
    bin.write_jar_script libexec/"astral.#{version}.jar", "astral"
  end

  test do
    system bin/"astral", "-i", pkgshare/"test_data/simulated_14taxon.gene.tre"
  end
end
