# Documentation: https://github.com/Homebrew/brew/blob/master/docs/Formula-Cookbook.md
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class SaneFrontends < Formula
  desc ""
  homepage ""
  url "http://http.debian.net/debian/pool/main/s/sane-frontends/sane-frontends_1.0.14.orig.tar.gz"
  version "1.0.14"
  sha256 "e7839dac1b70b5bb39124615aba8a136f5275d0e78bafd3d52ed76964ffea4a9"

  # depends_on "cmake" => :build
  # depends_on :x11 # if your formula requires any X11/XQuartz components
  
  depends_on "sane-backends"
  depends_on "net-snmp"
  depends_on "gtk+"

  patch :DATA

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel

    # Remove unrecognized options if warned by configure
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    # system "cmake", ".", *std_cmake_args
    system "make", "install" # if this fails, try separate make/make install steps
  end
end

__END__
--- src/gtkglue.c 2005-04-16 15:12:07.000000000 +0200
+++ src/gtkglue.c.new 2009-06-24 00:26:46.000000000 +0200
@@ -1476,8 +1476,7 @@
    || opt->type == SANE_TYPE_GROUP || !dialog->element[i].widget)
  continue;
 
-      if (!(opt->cap & SANE_CAP_ALWAYS_SETTABLE))
- gtk_widget_set_sensitive (dialog->element[i].widget, sensitive);
+      gtk_widget_set_sensitive (dialog->element[i].widget, sensitive);
     }
 }
 
