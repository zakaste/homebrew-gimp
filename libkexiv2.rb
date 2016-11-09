# Documentation: https://github.com/Homebrew/brew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Libkexiv2 < Formula
  desc ""
  homepage "http://www.digikam.org"
  url "http://download.kde.org/stable/applications/16.08.0/src/libkexiv2-16.08.0.tar.xz"
  version "16.08.0"
  sha256 "c71f5a96808696edcc1ca4d9fedbf9c74cd0a5b005e1c66b89cff2bf5c4c70a0"

  head "git://anongit.kde.org/libkexiv2.git"

   # depends_on
  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-dbus"
  #depends_on "libical"
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
