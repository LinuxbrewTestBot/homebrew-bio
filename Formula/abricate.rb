class Abricate < Formula
  desc "Find antimicrobial resistance and virulence genes in contigs"
  homepage "https://github.com/tseemann/abricate"
  url "https://github.com/tseemann/abricate/archive/v0.8.tar.gz"
  sha256 "287bc61518f86ffd04801bd8f2c7aeebb62b7c74b2fa154974c321efcee5a206"
  head "https://github.com/tseemann/abricate.git"

  bottle do
    root_url "https://homebrew.bintray.com/bottles-bio"
    prefix "/usr/local"
    cellar :any_skip_relocation
    rebuild 1
    sha256 "7375576e0c2bcf045bbaeb2f0705eba6e3758715fff1c0e20fb94f0ae51d8856" => :sierra
    sha256 "8f9f531e9a7123e6078613350842062133316d5c426e4f77ac39fc1609862817" => :x86_64_linux
  end

  depends_on "cpanminus" => :build
  depends_on "bioperl"
  depends_on "blast"
  depends_on "emboss"
  unless OS.mac?
    depends_on "perl"
    depends_on "unzip"
  end

  def install
    ENV.prepend "PERL5LIB", Formula["bioperl"].libexec/"lib/perl5"
    ENV.prepend_create_path "PERL5LIB", prefix/"perl5/lib/perl5"

    pms = %w[JSON Time::Piece File::Slurp Text::CSV]
    pms << "List::MoreUtils" unless OS.mac?
    system "cpanm", "--self-contained", "-l", prefix/"perl5", *pms

    libexec.install Dir["*"]
    %w[abricate abricate-get_db].each do |name|
      (bin/name).write_env_script("#{libexec}/bin/#{name}", :PERL5LIB => ENV["PERL5LIB"])
    end
  end

  def post_install
    system "#{bin}/abricate", "--setupdb"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/abricate --version")
    assert_match "resfinder", shell_output("#{bin}/abricate --list 2>&1")
    assert_match "--db", shell_output("#{bin}/abricate --help")
    assert_match "OK", shell_output("#{bin}/abricate --check 2>&1")
    assert_match "download", shell_output("#{bin}/abricate-get_db --help 2>&1")
  end
end
