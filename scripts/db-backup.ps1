param(
  [string]$OutputDir = "backups",
  [string]$ContainerName = "postgres",
  [string]$DbUser = "postgres",
  [string]$DbName = "mydb"
)

$ErrorActionPreference = "Stop"
$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
Push-Location $repoRoot

try {
  $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
  New-Item -Path $OutputDir -ItemType Directory -Force | Out-Null
  $outputPath = Join-Path $OutputDir "db-$timestamp.sql"

  Write-Host "Creating database backup at $outputPath ..."

  $dump = docker exec $ContainerName pg_dump -U $DbUser -d $DbName
  if ($LASTEXITCODE -ne 0) {
    throw "pg_dump failed. Ensure Docker container '$ContainerName' is running and credentials are valid."
  }

  $dump | Out-File -FilePath $outputPath -Encoding utf8
  Write-Host "Backup created: $outputPath"
}
finally {
  Pop-Location
}
