cask "vacs" do
  arch arm: "aarch64", intel: "x64"

  version "2.4.0"
  sha256 arm:   "61afca0d6440752c0758a1a9ceff451e4cdfb33e7e721e711aa238dc5e656383",
         intel: "4d889b01298febd6f2e7d00b5d8d38593b61c929ed2bdcdf071e3139e3026892"

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
