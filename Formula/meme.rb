class Meme < Formula
  # cite Bailey_2009: "https://doi.org/10.1093/nar/gkp335"
  desc "Tools for motif discovery"
  homepage "http://meme-suite.org"
  url "meme-suite.org/meme-software/5.0.5/meme-5.0.5.tar.gz"
  sha256 "94826793576f4dd2f10fef829426dcde57f3cc990e462d9428c84f83d71eaeeb"

  bottle do
    sha256 "7666afc3836d7dc257668e7b6070ffb75f9b71089f0d46527369f28353cbab84" => :x86_64_linux
  end

  # Work around the error:
  # ld: file not found: /usr/lib/system/libsystem_darwin.dylib
  depends_on :linux if ENV["CIRCLECI"]

  depends_on "open-mpi" => :optional
  unless OS.mac?
    depends_on "cpanminus" => :build
    depends_on "zlib" => :build
    depends_on "perl"
  end

  def install
    system "./configure", "--disable-dependency-tracking", "--prefix=#{libexec}", "--with-url=http://meme-suite.org/", "--enable-build-libxml2", "--enable-build-libxslt"
    system "make", "install"
    prefix.install "tests"
    perl_files = `grep -l -w "#!/usr/bin/perl" #{bin}/*`.split("\n")
    perl_files.each do |file|
      inreplace file, %r{^#!/usr/bin/perl.*}, "#!/usr/bin/env perl"
    end

    if OS.mac?
      bin.install_symlink libexec/"bin/meme"
    else
      ENV["PERL5LIB"] = libexec/"lib/perl5"
      system "cpanm", "--self-contained", "-l", libexec, "XML::Parser::Expat"
      (bin/"meme").write_env_script(libexec/"bin/meme", :PERL5LIB => ENV["PERL5LIB"])
    end
  end

  test do
    system bin/"meme", prefix/"tests/common/At.s"
  end
end
