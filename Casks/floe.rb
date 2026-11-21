cask "floe" do
  arch arm: "arm64", intel: "x64"

  version "2.0.2"
  sha256 arm:   "5957f35e28682ab2ffee73b3fab36ac200639e74cd3b1ae6729fd09f6940e7ac",
         intel: "1270c38a7519d6f83491ee6f618ac77359e237542c8c82ba9f8e6901cfc9c91a"

  url "https://github.com/Leo-luxy/Floe/releases/download/v#{version}/Floe-v#{version}-macos-#{arch}.dmg"
  name "Floe"
  desc "Modern cross-platform quantitative stock screening, backtesting, and AI research workbench"
  homepage "https://github.com/Leo-luxy/Floe"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :big_sur"

  app "Floe.app"
  binary "#{appdir}/Floe.app/Contents/MacOS/floe"

  postflight do
    # 开源免付费公证分发：自动移除浏览器/下载产生的隔离扩展属性，使普通用户双击即可直接启动
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/Floe.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/Floe",
    "~/Library/Preferences/io.github.leoluxy.floe.plist",
    "~/Library/Saved Application State/io.github.leoluxy.floe.savedState",
  ]
end
