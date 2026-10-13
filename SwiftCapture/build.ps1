$ErrorActionPreference = "Stop"

$compiler = "C:\Windows\Microsoft.NET\Framework64\v4.0.30319\csc.exe"
if (-not (Test-Path $compiler)) {
    $compiler = "C:\Windows\Microsoft.NET\Framework\v4.0.30319\csc.exe"
}
if (-not (Test-Path $compiler)) {
    throw "The .NET Framework C# compiler (csc.exe) was not found."
}

$source = Join-Path $PSScriptRoot "SwiftCapture.cs"
$output = Join-Path $PSScriptRoot "SwiftCapture.exe"
$naudio = Join-Path $PSScriptRoot "NAudio.dll"
if (-not (Test-Path $naudio)) {
    throw "NAudio.dll is missing from the app folder."
}
& $compiler /nologo /target:winexe /platform:x64 /optimize+ `
    /reference:System.dll /reference:System.Core.dll `
    /reference:System.Drawing.dll /reference:System.Windows.Forms.dll `
    "/reference:$naudio" `
    "/out:$output" $source
if ($LASTEXITCODE -ne 0) {
    throw "Compilation failed with exit code $LASTEXITCODE."
}
Write-Host "Built $output"
