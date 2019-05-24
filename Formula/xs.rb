class Xs < Formula
  desc "FASTQ read simulation tool"
  homepage "https://github.com/pratas/xs"
  url "https://github.com/pratas/xs/archive/v2.tar.gz"
  sha256 "3882f88dd757bee2d44cf2393af02084c572dd490dd8cbe55925cb2788777174"

  bottle do
    cellar :any_skip_relocation
    sha256 "48e751b687c927c43d976cb00f0de40c34ffe2a227305347f5024a35afd7bfc1" => :sierra
    sha256 "6d2091ed4c7664a11227107b830d18fe0945509a7aeeea0a7c8b5d5ebfd91eb8" => :x86_64_linux
  end

  def install
    system "make"
    bin.install "XS"
  end

  test do
    # Wrong exit code: https://github.com/pratas/xs/issues/6
    assert_match "FASTQ", shell_output("#{bin}/XS -h 2>&1", 1)
  end
end
