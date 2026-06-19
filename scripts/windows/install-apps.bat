@echo off
REM scripts/windows/install-apps.bat

dir

echo 💼 Installing Common apps and programs...
for /f "tokens=*" %%i in (winget\winget-common) do winget install --id %%i --silent --accept-source-agreements --accept-package-agreements

IF NOT "%1"=="work" (
    echo 🏠 Installing Personal apps and programs...
    for /f "tokens=*" %%i in (winget\winget-personal) do winget install --id %%i --silent --accept-source-agreements --accept-package-agreements
)

echo ✅ Finished installing apps and programs!
