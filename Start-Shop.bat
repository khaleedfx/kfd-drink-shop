@echo off
cd /d "%~dp0"
if not exist "runtime\python.exe" (
  echo First run: getting Python for this shop. Stay online.
  powershell -NoProfile -ExecutionPolicy Bypass -Command "Invoke-WebRequest -UseBasicParsing -Uri 'https://www.python.org/ftp/python/3.12.10/python-3.12.10-embed-amd64.zip' -OutFile ($env:TEMP + '\kfd-py.zip'); Expand-Archive -Force ($env:TEMP + '\kfd-py.zip') (Join-Path (Get-Location) 'runtime')"
)
start "K F and D Drink Shop" "%cd%\runtime\python.exe" "%cd%\python\shop_api.py"
timeout /t 2 /nobreak >nul
start msedge http://127.0.0.1:8080
if errorlevel 1 start http://127.0.0.1:8080
