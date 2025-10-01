class NasmSegelf < Formula
  desc "Nasm fork with segelf patches"
  homepage "https://github.com/stsp/nasm-segelf"
  url "https://github.com/stsp/nasm-segelf/archive/refs/tags/nasm-segelf-2.16.01-4.tar.gz"
  sha256 "1f4185bca8a12f3143239b51dab17241672b612e75d7d178736400db8c8b64ea"
  license "BSD-2-Clause"

  bottle do
    root_url "https://github.com/piperswe/homebrew-dosemu2/releases/download/nasm-segelf-2.16.01-4"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "3fcc63d137b6e8f97231648879b85933c338ee78a3a2077d35c4b6fb7f50ef82"
    sha256 cellar: :any_skip_relocation, sequoia:      "8b2545d4464f522b92d49c2cf8a8b97d091f1c6693492de2e5a7a68e8c1127dc"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f7e734e1e7f766de07959959e0d555fdf13d16390da5ab84975ada266f5e9bef"
  end

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
