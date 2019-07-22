class Salmid < Formula
  desc "Rapid confirmation of Salmonella species from WGS"
  homepage "https://github.com/hcdenbakker/SalmID"
  url "https://github.com/hcdenbakker/SalmID/archive/0.1.23.tar.gz"
  sha256 "aadcee6a7ba87ff4681129e86238d5edb7617dc4adf291e651b05ccb6d450cc9"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-bio"
    cellar :any_skip_relocation
    sha256 "6aefedde63baa9520c8a5100c3fbaf136b11ce025671f1145ec375ce5eca666f" => :sierra
    sha256 "f65d345e44e6e7ed6c5ece6cd3cd5ff1a460c1adfdd00e37a67cc1d0d9953c93" => :x86_64_linux
  end

  depends_on "python"

  def install
    prefix.install Dir["*"]
    bin.install_symlink "../SalmID.py"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/SalmID.py --version")
  end
end
