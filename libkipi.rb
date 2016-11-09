class Libkipi < Formula
  homepage "http://www.digikam.org"
  
  head "git://anongit.kde.org/libkipi.git"

   # depends_on
  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-dbus"
  depends_on "libkexiv2"
  #depends_on "shared-mime-info"
  #depends_on "ffmpeg"
  #depends_on "libav"
  #depends_on "python"
  
  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end
