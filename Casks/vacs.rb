cask "vacs" do
  arch arm: "aarch64", intel: "x64"

  version "2.7.0"
  sha256 arm:   "0031d52ab6e25a70812446b138314ebeb03d4eeeeb2c3a934ef19b1e12de1178",
         intel: "ede0506d73292f3c8b87ebcd147d43911ad3c0aab265916925f9b05fac8f7553"

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
