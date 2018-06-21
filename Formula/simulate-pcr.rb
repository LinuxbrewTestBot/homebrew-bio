class SimulatePcr < Formula
  # cite Gardner_2014: "https://doi.org/10.1186/1471-2105-15-237"
  desc "Predicts amplicon products from single or multiplex primers"
  homepage "https://sourceforge.net/projects/simulatepcr/"

  url "https://downloads.sourceforge.net/project/simulatepcr/simulate_PCR-v1.2.tar.gz"
  sha256 "022d1cc595d78a03b6a8a982865650f99d9fa067997bfea574c2416cc462e982"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-bio"
    cellar :any_skip_relocation
    sha256 "2bfe33208a09f150e4a6474b7bd46b36d18ad720da14a7bf95c649ab7b2138f8" => :sierra_or_later
    sha256 "41c781720102d0d12df2ce4e22122ec2a8b58be8c7df9dda0699243bed224eaa" => :x86_64_linux
  end

  depends_on "cpanminus" => :build
  depends_on "bioperl"
  depends_on "blast"
  depends_on "perl" unless OS.mac?

  def install
    bin.install "simulate_PCR"
    inreplace bin/"simulate_PCR", "#!/usr/bin/perl", "#!/usr/bin/env perl"
    ENV.prepend "PERL5LIB", Formula["bioperl"].libexec/"lib/perl5"
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    system "cpanm", "--self-contained", "-l", libexec, "IO::Socket::SSL", "LWP"
    bin.env_script_all_files libexec, "PERL5LIB" => ENV["PERL5LIB"]
  end

  test do
    assert_match "amplicon", shell_output("#{bin}/simulate_PCR 2>&1", 255)
  end
end
