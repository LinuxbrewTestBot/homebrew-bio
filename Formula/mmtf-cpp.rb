class MmtfCpp < Formula
  desc "The pure C++ implementation of the MMTF API, decoder and encoder"
  homepage "https://github.com/rcsb/mmtf-cpp"
  url "https://github.com/rcsb/mmtf-cpp/archive/v1.0.0.tar.gz"
  sha256 "881f69c4bb56605fa63fd5ca50842facc4947f686cbf678ad04930674d714f40"

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "msgpack"

  resource "173Dmmtf" do
    url "https://mmtf.rcsb.org/v1.0/full/173D.mmtf.gz"
    sha256 "5860449ba1c9faa04da183c413e607201f4c48370dee02e9f4af7e0d86408afa"
  end

  def install
    mkdir "build" do
      system "cmake", "..", "-G", "Ninja", *std_cmake_args
      system "ninja", "install"
    end
  end

  test do
    resource("173Dmmtf").stage do
      # Reference: https://github.com/rcsb/mmtf-cpp/blob/master/examples/mmtf_demo.cpp

      (testpath/"mmtf_demo.cpp").write <<~EOS
        #include <mmtf.hpp>
        #include <iostream>
        #include <string>

        int main(int argc, char** argv) {
            // check arguments
            if (argc < 2) {
              printf("USAGE: mmtf_demo <mmtffile>\n");
              return 1;
            }

            // decode MMTF file
            std::string filename(argv[1]);
            mmtf::StructureData data;
            mmtf::decodeFromFile(data, filename);

            // check if the data is self-consistent
            if (data.hasConsistentData(true)) {
              std::cout << "Successfully read " << filename << ".\n";
              return 0;
            } else {
              std::cout << "Inconsistent data in " << filename << ".\n";
              return 1;
            }
        }
      EOS

      system ENV.cc, "-o", "mmtf_demo", "mmtf_demo.cpp", "-L#{lib}", "-lmmtf"
      assert_match "Successfully read", `./mmtf_demo 173D.mmtf`
    end
  end
end
