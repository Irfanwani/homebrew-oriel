cask "oriel" do
  version "1.0.0"
  sha256 "151323f6de731bd4e030dcffe11f0d771790458e629518dc11791a62b932562f"

  url "https://github.com/Irfanwani/oriel/releases/download/v#{version}/Oriel-#{version}.dmg"
  name "Oriel"
  desc "Native auto-tiling window manager with Bento layouts, scenes and Overview"
  homepage "https://irfanwani.github.io/oriel/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sonoma"

  app "Oriel.app"
  binary "#{staged_path}/oriel"

  caveats <<~EOS
    Oriel is ad-hoc signed and not notarized. On first launch, macOS may ask you
    to approve it under System Settings → Privacy & Security.

    After installing an update, you may need to toggle Accessibility access for
    Oriel off and on again because the ad-hoc signature changes with each build.
  EOS
end
