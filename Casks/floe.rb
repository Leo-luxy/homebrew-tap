cask "floe" do
  arch arm:   "aa9af99e45fa29e801684486e460f2335f24537c7d981dfdc67dae5f9a6d57fb", intel: "e1f08386eb02abb31ef656e545d2720eb581ae91f1d7bac95916f9c02820d545"

  version "2.0.3"
  sha256 arm:   "aa9af99e45fa29e801684486e460f2335f24537c7d981dfdc67dae5f9a6d57fb",
         intel: "e1f08386eb02abb31ef656e545d2720eb581ae91f1d7bac95916f9c02820d545"

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
