# Dawson Oaks Trailer Park 繁體中文翻譯

《Dawson Oaks Trailer Park》繁體中文翻譯資料庫。

## 內容

- `translations/DawsonOaks_zh-TW.txt`：XUnity AutoTranslator 繁體中文翻譯檔。
- `UPDATE_GUIDE_zh-TW.md`：更新與安裝說明。

## 安裝

1. 安裝相容的 BepInEx 6 IL2CPP 與 XUnity AutoTranslator。
2. 將 `DawsonOaks_zh-TW.txt` 放到：
   `BepInEx/Translation/zh-TW/Text/`
3. 關閉 XUnity 的線上自動翻譯，只讀取人工校正翻譯。
4. 啟動遊戲。

## 發布範圍

本儲存庫只發布翻譯資料與說明文件，不包含 Patcher 原始碼、DLL、EXE、遊戲檔案、BepInEx、XUnity 或建置專案。

## 自動更新

排程會從本機遊戲資料夾讀取最新校正翻譯，通過格式、行數、重複鍵與縮減比例檢查後，才同步到本儲存庫。驗證失敗時保留上一版，不覆蓋線上檔案。

