# Documentation: https://github.com/Homebrew/brew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Libksane < Formula
  desc ""
  homepage "http://www.digikam.org"
  url "http://download.kde.org/stable/applications/16.08.0/src/libksane-16.08.0.tar.xz"
  version "16.08.0"
  sha256 "797da169728c08f62ba84ac1ae7f4c65089866d36ac29ed7c4c053fd63f12e1d"

  head "git://anongit.kde.org/libksane.git"
  
   # depends_on
  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-dbus"
  #depends_on "libkexiv2"
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
