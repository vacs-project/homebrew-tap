cask "vacs" do
  arch arm: "aarch64", intel: "x64"

  version "2.8.0"
  sha256 arm:   "876de17bf28fa111bc59fcde168e0daba6af3c3baf0e9477cbfeedd09fa86971",
         intel: "ad4e38dbc33e1dfe3aba4c9555c51d4a150384bced8d0556a2ee03ee2d263907"

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
