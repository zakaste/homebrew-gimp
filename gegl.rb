class Gegl < Formula
  desc "Graph based image processing framework"
  homepage "http://www.gegl.org/"
  url "http://download.gimp.org/pub/gegl/0.3/gegl-0.3.10.tar.bz2"
  mirror "https://mirrors.kernel.org/debian/pool/main/g/gegl/gegl_0.3.10.orig.tar.bz2"
  sha256 "26b4d6d0a8edb358ca2fbc097f9f97eec9d74e0ffe42f89fa1aff201728023d9"

  bottle do
    sha256 "26b4d6d0a8edb358ca2fbc097f9f97eec9d74e0ffe42f89fa1aff201728023d9" => :sierra
    sha256 "06ca9e67a59da026eb941b9d323269d7c19a922f1e478acdd3791a0eef8b229b" => :el_capitan
    sha256 "433625912481ffb5429be0986e726f03b11292f75dfd864d78340b9915e4411b" => :yosemite
    sha256 "a9960729dea6a983789a5abf32b3ae1aed304d3264ed084b61f9784680d3b478" => :mavericks
  end

  head do
    # Use the Github mirror because official git unreliable.
    url "https://github.com/GNOME/gegl.git"

    depends_on "automake" => :build
    depends_on "autoconf" => :build
    depends_on "libtool" => :build
  end

  option :universal

  depends_on "intltool" => :build
  depends_on "pkg-config" => :build
  depends_on "babl"
  depends_on "gettext"
  depends_on "glib"
  depends_on "json-glib"
  depends_on "libpng"
  depends_on "jpeg"
  depends_on "cairo" => :optional
  depends_on "librsvg" => :optional
  depends_on "lua" => :optional
  depends_on "pango" => :optional
  depends_on "sdl" => :optional

  def install
    # ./configure breaks when optimization is enabled with llvm
    ENV.no_optimization if ENV.compiler == :llvm

    argv = %W[
      --disable-debug
      --disable-dependency-tracking
      --prefix=#{prefix}
      --disable-docs
    ]

    if build.universal?
      ENV.universal_binary
      # ffmpeg's formula is currently not universal-enabled
      argv << "--without-libavformat"

      opoo "Compilation may fail at gegl-cpuaccel.c using gcc for a universal build" if ENV.compiler == :gcc
    end

    system "./autogen.sh" if build.head?
    system "./configure", *argv
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<-EOS.undent
      #include <gegl.h>
      gint main(gint argc, gchar **argv) {
        gegl_init(&argc, &argv);
        GeglNode *gegl = gegl_node_new ();
        gegl_exit();
        return 0;
      }
    EOS
    system ENV.cc, "-I#{include}/gegl-0.3", "-L#{lib}", "-lgegl-0.3",
           "-I#{Formula["babl"].opt_include}/babl-0.1",
           "-I#{Formula["glib"].opt_include}/glib-2.0",
           "-I#{Formula["glib"].opt_lib}/glib-2.0/include",
           "-L#{Formula["glib"].opt_lib}", "-lgobject-2.0", "-lglib-2.0",
           testpath/"test.c", "-o", testpath/"test"
    system "./test"
  end
end
