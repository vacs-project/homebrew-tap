cask "vacs" do
  arch arm: "aarch64", intel: "x64"

  version "2.5.0"
  sha256 arm:   "4e61dae6d86d50146b53adc26dc9e2448baf9b5f034f50e7d97808021712c325",
         intel: "db95f56322e5451a5493d9a535bdbf70032a5189bbe1159c6b7d46341fb2aeae"

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
