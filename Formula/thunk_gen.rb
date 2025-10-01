class ThunkGen < Formula
  desc "Thunk generator for C and assembler (used for dj64dev, comcom64, and fdpp)"
  homepage "https://github.com/stsp/thunk_gen"
  url "https://github.com/stsp/thunk_gen/archive/refs/tags/1.6.tar.gz"
  sha256 "d9252429b9998d8ccc68eaafa3d6504d4a9f47dc8068a841c4084658d0f2c9cf"
  license "GPL-3.0"

  bottle do
    root_url "https://github.com/piperswe/homebrew-dosemu2/releases/download/thunk_gen-1.6"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "27b0a02b3f5683a009d231c6d8e651f6e03ee21a6b3b447fac43a3ff8170ad07"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "36a28ed7c67a8e025388435cec17ee65ef98ea08a478611ffec34a02574d9707"
  end

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
