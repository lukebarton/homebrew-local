class Notificli < Formula
  desc "A lightweight, headless macOS command-line tool for sending actionable, persistent notifications"
  homepage "https://github.com/saihgupr/NotifiCLI"
  license "MIT"

  version "1.0.1"
  url "https://github.com/saihgupr/NotifiCLI/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "2dd9919c15df141c79301de1f56e493986762e9c90d3e2d1cb9097d2e40c8fa4"

  def install
    system "./build.sh"
    bin.install "build/NotifiCLI.app/Contents/MacOS/NotifiCLI" => "notificli"
  end

  test do
    system "#{bin}/notificli", "--help"
  end
end

