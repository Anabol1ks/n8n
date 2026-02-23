param(
  [string]$Url = "http://localhost:5678"
)

# Если передали пустую строку, тоже откатываемся к localhost
if ([string]::IsNullOrWhiteSpace($Url)) {
  $Url = "http://localhost:5678"
}

$Url = $Url.Trim().TrimEnd('/')

# Разрешаем:
# - https://... (для туннеля)
# - http://localhost:5678 (для локалки)
if (($Url -notmatch '^https://') -and ($Url -ne 'http://localhost:5678')) {
  Write-Host "Ошибка: укажи либо HTTPS URL туннеля (https://...), либо оставь пустым для http://localhost:5678" -ForegroundColor Red
  exit 1
}

# Подставляем переменные только на время запуска docker compose
$env:WEBHOOK_URL = "$Url/"
$env:WEBHOOK_TUNNEL_URL = "$Url/"

Write-Host "Запуск n8n с WEBHOOK_URL=$($env:WEBHOOK_URL)" -ForegroundColor Cyan

docker compose up -d --force-recreate

if ($LASTEXITCODE -ne 0) {
  Write-Host "Не удалось запустить n8n" -ForegroundColor Red
  exit $LASTEXITCODE
}

docker ps --filter "name=n8n"
