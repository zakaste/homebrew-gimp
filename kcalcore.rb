# Documentation: https://github.com/Homebrew/brew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Kcalcore < Formula
  desc ""
  homepage "https://projects.kde.org/projects/kde/pim/kcalcore"
  sha256 ""

  head 'git://anongit.kde.org/kcalcore.git'

   # depends_on
  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-dbus"
  depends_on "libical"
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
