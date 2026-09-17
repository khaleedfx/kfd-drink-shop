@echo off
title K F and D Drink Shop
cd /d "%~dp0"

if not exist "python\shop_api.py" (
  echo The shop file is missing.
  echo Extract the WHOLE folder first, then run Start-Shop.bat from inside that folder.
  pause
  exit /b 1
)

if not exist "runtime\python.exe" (
  echo First run: downloading Python. Keep internet on.
  mkdir runtime >nul 2>nul
  powershell -NoProfile -ExecutionPolicy Bypass -Command "Invoke-WebRequest -UseBasicParsing -Uri 'https://www.python.org/ftp/python/3.12.10/python-3.12.10-embed-amd64.zip' -OutFile ($env:TEMP + '\kfd-py.zip'); Expand-Archive -Force ($env:TEMP + '\kfd-py.zip') -DestinationPath (Join-Path (Get-Location) 'runtime')"
  if not exist "runtime\python.exe" (
    echo Could not get Python. Stay online and try again.
    pause
    exit /b 1
  )
)

echo Starting K F and D Drink Shop...
echo Leave this window open.
echo.
start "" cmd /c "timeout /t 4 /nobreak >nul & start http://127.0.0.1:8080"
"runtime\python.exe" "python\shop_api.py"
echo.
echo The shop stopped. If it failed, the message is above.
pause
