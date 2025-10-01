class NasmSegelf < Formula
  desc "Nasm fork with segelf patches"
  homepage "https://github.com/stsp/nasm-segelf"
  url "https://github.com/stsp/nasm-segelf/archive/refs/tags/nasm-segelf-2.16.01-4.tar.gz"
  sha256 "1f4185bca8a12f3143239b51dab17241672b612e75d7d178736400db8c8b64ea"
  license "BSD-2-Clause"

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"foo.s").write <<~ASM
      mov eax, 0
      mov ebx, 0
      int 0x80
    ASM

    system bin/"nasm-segelf", "foo.s"
    code = File.open("foo", "rb") { |f| f.read.unpack("C*") }
    expected = [0x66, 0xb8, 0x00, 0x00, 0x00, 0x00, 0x66, 0xbb,
                0x00, 0x00, 0x00, 0x00, 0xcd, 0x80]
    assert_equal expected, code
  end
end
