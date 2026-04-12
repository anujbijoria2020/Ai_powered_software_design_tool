$ErrorActionPreference = "Stop"
$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
Push-Location $repoRoot

try {
  Write-Host "Resetting local database via Prisma migrations ..."
  npx prisma migrate reset --force --skip-seed
  if ($LASTEXITCODE -ne 0) {
    throw "Database reset failed."
  }

  Write-Host "Regenerating Prisma client ..."
  npx prisma generate
  if ($LASTEXITCODE -ne 0) {
    throw "Prisma client generation failed after reset."
  }

  Write-Host "Database reset complete."
}
finally {
  Pop-Location
}
