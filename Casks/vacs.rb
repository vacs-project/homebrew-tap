cask "vacs" do
  arch arm: "aarch64", intel: "x64"

  version "2.3.0"
  sha256 arm:   "f2f81db964e4930cde8056ec114a7a5f77cdc14570b023af6462332cca7bce20",
         intel: "8ab0d080ad42d4433729fde4aa0f13bb33d9bcb7eafe52928dc0d82ead1e18f9"

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
