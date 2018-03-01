class Skesa < Formula
  desc "Strategic Kmer Extension for Scrupulous Assemblies"
  homepage "https://ftp.ncbi.nlm.nih.gov/pub/agarwala/skesa/"
  url "https://ftp.ncbi.nlm.nih.gov/pub/agarwala/skesa/skesa.static"
  version "2.1"
  sha256 "2c36e0bdc6372795876fe1ce87cb3a32e66cb113fd5be2b0e2e33f1ded0db138"

  bottle do
    cellar :any_skip_relocation
    sha256 "9ecfd501164b0e6f4f33b0b2363134846c9d4b484e56fe985ad249db8716e3b8" => :x86_64_linux
  end

  depends_on :linux

  unless OS.mac?
    depends_on "patchelf" => :build
    depends_on "zlib"
  end

  def install
    bin.install "skesa.static" => "skesa"
    unless OS.mac?
      system "patchelf",
        "--set-interpreter", HOMEBREW_PREFIX/"lib/ld.so",
        "--set-rpath", HOMEBREW_PREFIX/"lib",
        bin/"skesa"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/skesa --version 2>&1")
  end
end
