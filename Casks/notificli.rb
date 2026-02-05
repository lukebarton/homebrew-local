cask "notificli" do
  version "1.0.1"
  sha256 :no_check

  url "https://github.com/saihgupr/NotifiCLI/archive/refs/tags/v#{version}.tar.gz"
  name "NotifiCLI"
  desc "A lightweight, headless macOS command-line tool for sending actionable, persistent notifications"
  homepage "https://github.com/saihgupr/NotifiCLI"

  # macOS quarantines source archives; remove before building
  preflight do
    system_command "xattr",
      args: ["-dr", "com.apple.quarantine", staged_path],
      sudo: true
  end

  # Build the app from source
  installer script: {
    executable: "bash",
    args: ["-lc", "cd '#{staged_path}/NotifiCLI-#{version}' && ./build.sh"],
  }

  # Install the app bundle
  app "NotifiCLI-#{version}/build/NotifiCLI.app"

  # Optional: expose the CLI on PATH (Homebrew-idiomatic replacement for ln -s)
  binary "#{appdir}/NotifiCLI.app/Contents/MacOS/NotifiCLI", target: "notificli"

  # Avoid Gatekeeper prompt on first launch
  postflight do
    system_command "xattr",
      args: ["-dr", "com.apple.quarantine", "#{appdir}/NotifiCLI.app"]
  end

  uninstall delete: "#{appdir}/NotifiCLI.app"

  zap trash: [
    "~/Library/Application Support/NotifiCLI",
    "~/Library/Preferences/com.notificli.plist",
  ]
end

