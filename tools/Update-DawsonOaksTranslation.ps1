[CmdletBinding()]
param(
    [string]$GameDir = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
)

$ErrorActionPreference = 'Stop'
$translationUrl = 'https://raw.githubusercontent.com/XoF-eLtTiL/Dawson-Oaks-Traditional-Chinese/main/translations/DawsonOaks_zh-TW.txt'
$checksumsUrl = 'https://raw.githubusercontent.com/XoF-eLtTiL/Dawson-Oaks-Traditional-Chinese/main/SHA256SUMS.txt'
$expectedRelativePath = 'translations/DawsonOaks_zh-TW.txt'
$gameExe = Join-Path $GameDir 'Dawson Oaks Trailer Park.exe'
$targetDirectory = Join-Path $GameDir 'BepInEx\Translation\zh-TW\Text'
$target = Join-Path $targetDirectory 'DawsonOaks_zh-TW.txt'
$backupDirectory = Join-Path $targetDirectory 'Backups'
$temporary = Join-Path $targetDirectory ".DawsonOaks_zh-TW.download.$PID.tmp"

function Write-Step([string]$Message) {
    Write-Host "[繁中更新] $Message" -ForegroundColor Cyan
}

try {
    Write-Step "遊戲目錄：$GameDir"
    if (-not (Test-Path -LiteralPath $gameExe)) {
        throw "找不到遊戲執行檔：$gameExe`n請把 BAT 與 tools 資料夾放在遊戲根目錄後再執行。"
    }

    if (Get-Process -Name 'Dawson Oaks Trailer Park' -ErrorAction SilentlyContinue) {
        throw '遊戲仍在執行。請先關閉 Dawson Oaks Trailer Park，再重新執行更新。'
    }

    New-Item -ItemType Directory -Path $targetDirectory -Force | Out-Null
    Write-Step '正在讀取 GitHub 校驗碼與最新版人工翻譯……'

    Add-Type -AssemblyName System.Net.Http
    $client = [System.Net.Http.HttpClient]::new()
    try {
        $client.Timeout = [TimeSpan]::FromSeconds(20)
        $client.DefaultRequestHeaders.UserAgent.ParseAdd('DawsonOaks-ZhTW-ManualUpdater/1.0')
        $client.DefaultRequestHeaders.CacheControl = [System.Net.Http.Headers.CacheControlHeaderValue]::new()
        $client.DefaultRequestHeaders.CacheControl.NoCache = $true
        $checksums = $client.GetStringAsync($checksumsUrl).GetAwaiter().GetResult()
        $bytes = $client.GetByteArrayAsync($translationUrl).GetAwaiter().GetResult()
    }
    finally {
        $client.Dispose()
    }

    $match = [regex]::Match($checksums, "(?im)^([0-9a-f]{64})\s+$([regex]::Escape($expectedRelativePath))\s*$")
    if (-not $match.Success) {
        throw 'GitHub 校驗檔沒有翻譯檔紀錄，為避免覆蓋正確檔案，已停止更新。'
    }
    $expectedHash = $match.Groups[1].Value.ToUpperInvariant()

    $utf8 = [System.Text.UTF8Encoding]::new($false, $true)
    $text = $utf8.GetString($bytes)
    if ($bytes.Length -lt 50000 -or $text -match '(?i)<html|<!doctype') {
        throw '下載內容過小或看起來是網頁錯誤頁面，已停止更新。'
    }
    $lines = $text -split "`r?`n"
    $translationLines = @($lines | Where-Object { $_ -match '^(?:r:|sr:)?[^#].*=' }).Count
    if ($lines.Count -lt 1000 -or $translationLines -lt 900) {
        throw "翻譯格式檢查失敗（總行數 $($lines.Count)，翻譯行 $translationLines），已停止更新。"
    }

    [System.IO.File]::WriteAllBytes($temporary, $bytes)
    $actualHash = (Get-FileHash -LiteralPath $temporary -Algorithm SHA256).Hash
    if (-not $actualHash.Equals($expectedHash, [StringComparison]::OrdinalIgnoreCase)) {
        throw "SHA-256 不符。預期 $expectedHash，實際 $actualHash。原翻譯未被修改。"
    }

    if (Test-Path -LiteralPath $target) {
        $currentHash = (Get-FileHash -LiteralPath $target -Algorithm SHA256).Hash
        if ($currentHash.Equals($actualHash, [StringComparison]::OrdinalIgnoreCase)) {
            Remove-Item -LiteralPath $temporary -Force
            Write-Host '目前已是最新版翻譯，不需要更新。' -ForegroundColor Green
            exit 0
        }

        New-Item -ItemType Directory -Path $backupDirectory -Force | Out-Null
        $stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
        $backup = Join-Path $backupDirectory "DawsonOaks_zh-TW.$stamp.txt"
        [System.IO.File]::Replace($temporary, $target, $backup, $true)
        Write-Step "舊翻譯已備份：$backup"
    }
    else {
        [System.IO.File]::Move($temporary, $target)
    }

    Write-Host '翻譯更新完成。' -ForegroundColor Green
    Write-Host "版本雜湊：$actualHash"
    Write-Host "安裝位置：$target"
    exit 0
}
catch {
    if (Test-Path -LiteralPath $temporary) {
        Remove-Item -LiteralPath $temporary -Force -ErrorAction SilentlyContinue
    }
    Write-Host ''
    Write-Host "更新失敗：$($_.Exception.Message)" -ForegroundColor Red
    Write-Host '現有翻譯檔已保留。'
    exit 1
}
