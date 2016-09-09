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

  def install
    args = std_cmake_args

    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"
  end
end