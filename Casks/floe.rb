cask "floe" do
  arch arm: "arm64", intel: "x64"

  version "2.1.0"
  sha256 arm:   "7167608f21def1416065fba9e074cfce3c6f38105e3e3e3264d19e31dcec2e62",
         intel: "61ad513b0c72b48e13372900662b0843538f9b38157c7407aad16b854701816a"

  url "https://github.com/Leo-luxy/Floe/releases/download/v#{version}/Floe-v#{version}-macos-#{arch}.dmg"
  name "Floe"
  desc "Modern cross-platform quantitative stock screening, backtesting, and AI research workbench"
  homepage "https://github.com/Leo-luxy/Floe"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :big_sur

  app "Floe.app"
  binary "#{appdir}/Floe.app/Contents/MacOS/floe"

  postflight_steps do
    # 开源免付费公证分发：自动移除浏览器/下载产生的隔离扩展属性，使普通用户双击即可直接启动
    run "/usr/bin/xattr", args: ["-cr", "{{appdir}}/Floe.app"], must_succeed: false
  end

  zap trash: [
    "~/Library/Application Support/Floe",
    "~/Library/Preferences/io.github.leoluxy.floe.plist",
    "~/Library/Saved Application State/io.github.leoluxy.floe.savedState",
  ]
end
