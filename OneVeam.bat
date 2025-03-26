@echo off
REM =============================================================
REM OneVeamScript.bat - Activar/Desactivar Servicios de Veeam
REM =============================================================
echo Verificando privilegios de administrador...
openfiles >nul 2>&1
if %errorlevel% NEQ 0 (
    echo Por favor, ejecute este script como administrador.
    pause
    exit /b
)

:menu
cls
echo ================================================
echo          OneVeamScript - Servicios Veeam
echo ================================================
echo.
echo 1. Activar TODOS los servicios de Veeam
echo 2. Desactivar TODOS los servicios de Veeam
echo 3. Salir
echo.
set /p opcion="Seleccione una opcion [1-3]: "

if "%opcion%"=="1" goto activar
if "%opcion%"=="2" goto desactivar
if "%opcion%"=="3" goto salir

echo Opcion invalida, intente nuevamente.
pause
goto menu

:activar
echo.
echo Activando servicios de Veeam...
REM Lista de servicios Veeam a activar
set services=VeeamBackupSvc VeeamDeploySvc VeeamTransportSvc VeeamBrokerSvc VeeamFilesysVssSvc VeeamDistributionSvc VeeamNFSSvc
for %%s in (%services%) do (
    echo Activando %%s...
    sc config %%s start= auto
    sc start %%s
)
echo.
echo Todos los servicios de Veeam han sido ACTIVADOS.
pause
goto menu

:desactivar
echo.
echo Desactivando servicios de Veeam...
REM Lista de servicios Veeam a desactivar
set services=VeeamBackupSvc VeeamDeploySvc VeeamTransportSvc VeeamBrokerSvc VeeamFilesysVssSvc VeeamDistributionSvc VeeamNFSSvc
for %%s in (%services%) do (
    echo Desactivando %%s...
    sc stop %%s
    sc config %%s start= disabled
)
echo.
echo Todos los servicios de Veeam han sido DESACTIVADOS.
pause
goto menu

:salir
echo.
echo Saliendo del script...
exit /b
