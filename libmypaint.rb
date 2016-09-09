class Libmypaint < Formula
  desc "libmypaint"
  homepage "https://github.com/mypaint/libmypaint/"
  url "https://github.com/mypaint/libmypaint/archive/v1.3.0-beta.1.tar.gz"
  version "1"
  sha256 "bb9b2848e416da97f989a29eb6b09161b9bfda8141785ea901acacfecb21dd99"

  # depends_on "cmake" => :build
  # depends_on :x11 # if your formula requires any X11/XQuartz components

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "intltool" => :build
  depends_on "pkg-config" => :build
  depends_on "json-c"
  depends_on "gettext"

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel

    # Remove unrecognized options if warned by configure
    system "./autogen.sh"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    # system "cmake", ".", *std_cmake_args
    system "make", "check", "install" # if this fails, try separate make/make install steps
  end

  #test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test libmypaint`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
   # system "false"
  #end
end
