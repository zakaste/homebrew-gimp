require "formula"

class Kfilemetadata < Formula
  url "http://download.kde.org/stable/frameworks/5.25/kfilemetadata-5.25.0.tar.xz"
  version "5.25.0"
  sha256 "f7f7ede8b3a7a518e8058374733847c2610b59aa717562c253f70a01c614ebf9"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kfilemetadata.git'

  # depends_on
  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-dbus"
  depends_on "shared-mime-info"
  depends_on "ffmpeg"
  depends_on "libav"
  depends_on "python"

  patch :DATA
  
  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end

__END__
--- a/CMakeLists.txt  2016-08-07 15:47:54.000000000 +0200
+++ b/CMakeLists.txt 2016-09-10 20:35:22.000000000 +0200
@@ -61,10 +61,12 @@ set_package_properties(CatDoc PROPERTIES
                        URL "http://www.wagner.pp.ru/~vitus/software/catdoc/" TYPE RUNTIME
                        PURPOSE "Extract text from office 98 files - RUNTIME dependency")
 
-find_package(Xattr)
-set_package_properties(Xattr PROPERTIES
-    URL "http://savannah.nongnu.org/projects/attr"
-    TYPE REQUIRED)
+if ( CMAKE_SYSTEM_NAME MATCHES "Linux" )
+    find_package(Xattr)
+    set_package_properties(Xattr PROPERTIES
+        URL "http://savannah.nongnu.org/projects/attr"
+        TYPE REQUIRED)
+endif()
 
 #find_package(QMobipocket)
 #set_package_properties(QMobipocket PROPERTIES DESCRIPTION "Mobipocket epub reader"
