cask "vacs" do
  arch arm: "aarch64", intel: "x64"

  version "3.0.1"
  sha256 arm:   "ee46d0a32a3e207e1f8361479af494e5e6eea86e71fe3b29dfc0f97c22b6c892",
         intel: "0e71c333410d7988c7297b22eb248126d5ba98f1cce30f031f3e26f626dde818"

  url "https://github.com/vacs-project/vacs/releases/download/vacs-client-v#{version}/vacs_#{version}_#{arch}.dmg",
      verified: "github.com/vacs-project/vacs/"
  name "vacs"
  desc "Ground-to-ground voice communication system for VATSIM controllers"
  homepage "https://vacs.network/"

  livecheck do
    url :url
    strategy :github_latest
    regex(/^vacs-client-v(\d+\.\d+\.\d+)$/i)
  end

  auto_updates true
  depends_on macos: :monterey

  app "vacs.app"

  zap trash: [
    "~/Library/Application Support/app.vacs.vacs-client",
    "~/Library/Logs/app.vacs.vacs-client",
  ]

  caveats do
    <<~EOS
      vacs is currently not notarized. On first launch, macOS may block the app.
      If needed, remove quarantine attributes manually:

        sudo xattr -rd com.apple.quarantine /Applications/vacs.app
    EOS
  end
end
