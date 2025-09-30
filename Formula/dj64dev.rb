class Dj64dev < Formula
  desc "MS-DOS cross compilation suite"
  homepage "https://github.com/stsp/dj64dev/"
  url "https://github.com/stsp/dj64dev/archive/refs/tags/0.3.tar.gz"
  sha256 "d6cd05e92b1f46f20190a4a0fb8dc5a37f0f4dd29380a35651cb974b6501a975"
  license "GPL-3.0-or-later"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "gnu-sed" => :build
  depends_on "lld" => :build
  depends_on "llvm" => :build
  depends_on "pkgconf" => :build
  depends_on "thunk_gen" => :build
  depends_on "universal-ctags" => :build
  depends_on :linux
  depends_on "ncurses"

  on_macos do
    depends_on "libelf"
  end

  on_linux do
    depends_on "elfutils"
  end

  def install
    ENV.prepend_path "PATH", Formula["gnu-sed"].libexec/"gnubin" if OS.mac?
    system "make", "./configure"
    system "./configure", "--prefix=#{prefix}"
    system "make", "-C", "src", "makemake.exe"
    system "make"
    system "make", "install"
  end

  test do
    system "true"
  end
end
