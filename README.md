# Dawson Oaks Trailer Park 繁體中文翻譯

《Dawson Oaks Trailer Park》（道森橡樹拖車公園）非官方繁體中文化、Traditional Chinese／zh-TW localization 專案。

[![Latest Release](https://img.shields.io/github/v/release/XoF-eLtTiL/Dawson-Oaks-Traditional-Chinese?label=最新版)](https://github.com/XoF-eLtTiL/Dawson-Oaks-Traditional-Chinese/releases/latest)
[![GitHub Downloads](https://img.shields.io/github/downloads/XoF-eLtTiL/Dawson-Oaks-Traditional-Chinese/total?label=下載次數)](https://github.com/XoF-eLtTiL/Dawson-Oaks-Traditional-Chinese/releases)

提供遊戲介面、教學、角色建立、設定、聊天與手機輸入相關的繁體中文翻譯和修補程式，支援 BepInEx 6 IL2CPP、XUnity AutoTranslator、中文字體與 GitHub 自動更新。

**快速連結：** [下載最新版](https://github.com/XoF-eLtTiL/Dawson-Oaks-Traditional-Chinese/releases/latest) · [詳細安裝與更新教學](UPDATE_GUIDE_zh-TW.md) · [繁體中文翻譯檔](translations/DawsonOaks_zh-TW.txt)

## 內容

- `translations/DawsonOaks_zh-TW.txt`：XUnity AutoTranslator 繁體中文翻譯檔。
- `UPDATE_GUIDE_zh-TW.md`：完整安裝、更新、移除與故障排除教學。
- `手動更新翻譯.bat`：放在遊戲根目錄後可雙擊更新翻譯。
- `tools/Update-DawsonOaksTranslation.ps1`：具備 SHA-256 與格式驗證、備份及安全替換的更新工具。
- GitHub Release：完整安裝包、已編譯修補 DLL、更新器 DLL、更新清單與 SHA-256。

## 安裝

1. 安裝相容的 BepInEx 6 IL2CPP 與 XUnity AutoTranslator。
2. 將 `DawsonOaks_zh-TW.txt` 放到：
   `BepInEx/Translation/zh-TW/Text/`
3. 關閉 XUnity 的線上自動翻譯，只讀取人工校正翻譯。
4. 啟動遊戲。

## 發布範圍

儲存庫只發布翻譯資料、說明文件、已編譯 DLL 與更新清單；不發布 Patcher 原始碼、建置專案或遊戲檔案。完整安裝包由版本頁提供。

## 自動更新

`DawsonOaks.ZhTW.Updater.dll` 在 BepInEx 預載階段讀取 GitHub 最新版本，只有在檔名白名單、版本與 SHA-256 驗證通過後，才更新主修補 DLL。遠端版本較舊、網路失敗或驗證失敗時會保留現有版本。更新器不會下載或覆蓋本機人工校正的翻譯檔。

## v1.0.20

- 中文大廳聊天解除 32 字輸入限制，長訊息採安全分段並於接收端重組。
- 修正繁體中文 Logo 在換場景後被 Unity 卸載或被原圖覆蓋的問題。
- 場景切換後會在 UI 建立期間持續確認並重新套用 Logo。
- 自動更新器加入版本防降級，且不更新翻譯檔。

翻譯同步排程會從本機遊戲資料夾讀取最新校正翻譯，通過格式、行數、重複鍵與縮減比例檢查後，才同步到本儲存庫。

## 搜尋名稱

Dawson Oaks Traditional Chinese、Dawson Oaks Trailer Park 中文、Dawson Oaks 繁體中文、Dawson Oaks 中文化、道森橡樹拖車公園中文、Dawson Oaks BepInEx、Dawson Oaks XUnity、Dawson Oaks zh-TW。

