cask "vacs" do
  arch arm: "aarch64", intel: "x64"

  version "2.6.0"
  sha256 arm:   "fd7403bbecb6c5bba3088ec0bcace1f8b788f84f2560588d0e3bfdf54463669c",
         intel: "7ecc3fe3686096b3f118c0b6f26e29f77f75f67c4b2b2b1002d8fbb30b8aa302"

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
