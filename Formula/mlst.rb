class Mlst < Formula
  desc "Multi-Locus Sequence Typing of bacterial contigs"
  homepage "https://github.com/tseemann/mlst"
  url "https://github.com/tseemann/mlst/archive/v2.12.tar.gz"
  sha256 "a8df8301e5b51e6484ddd0f7cbd551b3d25cc4d46135ec67745109a2721c42b2"
  head "https://github.com/tseemann/mlst.git"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-bio"
    prefix "/usr/local"
    cellar :any_skip_relocation
    sha256 "fb743c4888af134b497225316e37ac8f183ed5493f3c55f0e854751a00d01bfa" => :sierra_or_later
    sha256 "3e5f5a7e861a4eb77ca92a470e244d0567ceb8997d3add4bc62054d4a70e4e39" => :x86_64_linux
  end

  depends_on "cpanminus" => :build
  depends_on "pkg-config" => :build

  depends_on "blast"
  unless OS.mac?
    depends_on "gzip"
    depends_on "perl"
  end
  depends_on "wget"

  def install
    libexec.install Dir["*"]
    ENV.prepend_create_path "PERL5LIB", libexec/"lib/perl5"
    system "cpanm", "--self-contained", "-l", libexec, "Moo", "List::MoreUtils", "JSON"
    (bin/"mlst").write_env_script("#{libexec}/bin/mlst", :PERL5LIB => ENV["PERL5LIB"])
  end

  test do
    tdir = libexec/"test"
    assert_match version.to_s, shell_output("#{bin}/mlst --version")
    assert_match "senterica", shell_output("#{bin}/mlst --list 2>&1")
    system "#{bin}/mlst", "--check"
    system "#{bin}/mlst -q #{tdir}/example.fna.gz | grep -w 184"
    system "#{bin}/mlst -q #{tdir}/example.gbk.gz | grep -w 184"
    system "gzip -d -c #{tdir}/example.fna.gz | #{bin}/mlst -q /dev/stdin | grep -w 184"
    system "gzip -d -c #{tdir}/example.gbk.gz | #{bin}/mlst -q /dev/stdin | grep -w 184"
    system "#{bin}/mlst -q --csv #{tdir}/example.fna.gz | grep ',184,'"
  end
end
