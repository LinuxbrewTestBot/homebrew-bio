class Flowcraft < Formula
  desc "Nextflow pipeline assembler for genomics"
  homepage "https://github.com/assemblerflow/flowcraft"
  url "https://github.com/assemblerflow/flowcraft/archive/1.3.1.tar.gz"
  sha256 "77d5289bd5fcbf05917b36764bb1ed5544d54f32c386270f230b5c6e8bc48bb7"
  revision 1
  head "https://github.com/assemblerflow/flowcraft.git", :branch => "dev"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles-bio"
    cellar :any_skip_relocation
    rebuild 1
    sha256 "ef1217a1dda4b94b0be0f9f72e145b10c79676a1e87852700fa2f007ed81f19d" => :sierra_or_later
    sha256 "01a62a984e165305d680495b13cff1a0c9dce9e13a2521a29a0400c646022cd9" => :x86_64_linux
  end

  depends_on "nextflow"
  depends_on "python"

  def install
    xy = Language::Python.major_minor_version "python3"
    ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python#{xy}/site-packages"
    system "python3", "setup.py", "install", "--prefix=#{libexec}"
    (bin/"flowcraft").write_env_script libexec/"bin/flowcraft", :PYTHONPATH => ENV["PYTHONPATH"]
  end

  test do
    assert_match "usage", shell_output("#{bin}/flowcraft --help")
  end
end
