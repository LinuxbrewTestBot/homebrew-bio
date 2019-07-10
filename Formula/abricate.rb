class Abricate < Formula
  desc "Find antimicrobial resistance and virulence genes in contigs"
  homepage "https://github.com/tseemann/abricate"
  url "https://github.com/tseemann/abricate/archive/v0.8.13.tar.gz"
  sha256 "21cae491e40ee12ce34fd6fbcc93ca3ed12d88a9a774b9f8e62da36078b8292d"
  revision 1
  head "https://github.com/tseemann/abricate.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "2a0d5ca4c023c3a6861b832a04207e0ff44e895360d2e98b70ed32e3a6575c13" => :sierra
    sha256 "f166e269d2235aed9eb1b8eead6c81abe23e5dc68996639457bf7ae9fe6d15d3" => :x86_64_linux
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

    pms = %w[JSON Time::Piece Text::CSV List::MoreUtils]
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
