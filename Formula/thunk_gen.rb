class ThunkGen < Formula
  desc "Thunk generator for C and assembler (used for dj64dev, comcom64, and fdpp)"
  homepage "https://github.com/stsp/thunk_gen"
  url "https://github.com/stsp/thunk_gen/archive/refs/tags/1.6.tar.gz"
  sha256 "d9252429b9998d8ccc68eaafa3d6504d4a9f47dc8068a841c4084658d0f2c9cf"
  license "GPL-3.0"

  depends_on "bison" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build

  def install
    system "meson", "setup", "build", *std_meson_args
    system "meson", "compile", "-C", "build"
    system "meson", "install", "-C", "build"
  end

  test do
    system "test", "-e", libexec/"thunk_gen/thunk_gen"
  end
end
