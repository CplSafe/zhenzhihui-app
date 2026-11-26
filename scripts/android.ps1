param(
  [switch]$BuildOnly,
  [string]$Device = ''
)

$ErrorActionPreference = 'Stop'
$projectRoot = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot '..')).Path
$drive = @('Z','Y','X','W','V','U','T','S','R') | Where-Object {
  -not (Test-Path -LiteralPath "${_}:\")
} | Select-Object -First 1
if (-not $drive) { throw 'No free drive letter from R to Z is available.' }

& subst.exe "${drive}:" $projectRoot
if ($LASTEXITCODE -ne 0) { throw 'Failed to create the temporary project drive.' }
try {
  Push-Location "${drive}:\"
  try {
    if ($BuildOnly) {
      & flutter.bat build apk --debug
    } elseif ($Device) {
      & flutter.bat run -d $Device
    } else {
      & flutter.bat run
    }
    $flutterExit = $LASTEXITCODE
  } finally {
    Pop-Location
  }
} finally {
  & subst.exe "${drive}:" /D
}
exit $flutterExit
