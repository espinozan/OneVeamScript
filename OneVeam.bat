@echo off
:: =============================================================
:: OneVeamScript.bat - Gestión de servicios Veeam
:: =============================================================

:: Si se pasa un parámetro, ejecutar la acción directamente
if /I "%1"=="activate" goto activar
if /I "%1"=="deactivate" goto desactivar

:: Verificar si se ejecuta como administrador
openfiles >nul 2>&1
if %errorlevel% NEQ 0 (
    echo Por favor, ejecute este script como administrador.
    pause
    exit /b
)

:menu
cls
echo ================================================
echo        OneVeamScript - Servicios Veeam
echo ================================================
echo.
echo 1. Activar TODOS los servicios de Veeam ahora
echo 2. Desactivar TODOS los servicios de Veeam ahora
echo 3. Programar activacion de servicios al inicio (on logon)
echo 4. Programar desactivacion de servicios al inicio (on logon)
echo 5. Programar tarea personalizada (definir hora y accion)
echo 6. Cancelar tareas programadas (OneVeamActivate, OneVeamDeactivate, OneVeamCustom)
echo 7. Salir
echo.
set /p opcion="Seleccione una opcion [1-7]: "

if "%opcion%"=="1" goto activar
if "%opcion%"=="2" goto desactivar
if "%opcion%"=="3" goto schedule_startup_activate
if "%opcion%"=="4" goto schedule_startup_deactivate
if "%opcion%"=="5" goto schedule_custom
if "%opcion%"=="6" goto cancel_tasks
if "%opcion%"=="7" goto salir

echo Opcion invalida, intente nuevamente.
pause
goto menu

:activar
echo.
echo Activando servicios de Veeam...
:: Lista de servicios de Veeam a activar
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
:: Lista de servicios de Veeam a desactivar
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

:schedule_startup_activate
echo.
echo Programando activacion de servicios de Veeam al inicio (on logon)...
set taskName=OneVeamActivate
set taskAction=%~dp0OneVeamScript.bat activate
:: Si la tarea ya existe, se elimina para recrearla
schtasks /query /tn "%taskName%" >nul 2>&1
if %errorlevel%==0 (
    echo Tarea "%taskName%" ya existe. Se eliminará para recrearla.
    schtasks /delete /tn "%taskName%" /f
)
schtasks /create /tn "%taskName%" /tr "\"%taskAction%\"" /sc onlogon /rl highest
if %errorlevel%==0 (
    echo Tarea programada "%taskName%" creada correctamente.
) else (
    echo Error al crear la tarea programada.
)
pause
goto menu

:schedule_startup_deactivate
echo.
echo Programando desactivacion de servicios de Veeam al inicio (on logon)...
set taskName=OneVeamDeactivate
set taskAction=%~dp0OneVeamScript.bat deactivate
schtasks /query /tn "%taskName%" >nul 2>&1
if %errorlevel%==0 (
    echo Tarea "%taskName%" ya existe. Se eliminará para recrearla.
    schtasks /delete /tn "%taskName%" /f
)
schtasks /create /tn "%taskName%" /tr "\"%taskAction%\"" /sc onlogon /rl highest
if %errorlevel%==0 (
    echo Tarea programada "%taskName%" creada correctamente.
) else (
    echo Error al crear la tarea programada.
)
pause
goto menu

:schedule_custom
echo.
echo Configuracion de tarea personalizada.
set /p customAction="Ingrese la accion a programar (activate/deactivate): "
if /I not "%customAction%"=="activate" if /I not "%customAction%"=="deactivate" (
    echo Accion invalida. Debe ser 'activate' o 'deactivate'.
    pause
    goto menu
)
set /p customTime="Ingrese la hora (HH:MM en formato 24h) para ejecutar la tarea (diaria): "
set taskName=OneVeamCustom
set taskAction=%~dp0OneVeamScript.bat %customAction%
schtasks /query /tn "%taskName%" >nul 2>&1
if %errorlevel%==0 (
    echo Tarea "%taskName%" ya existe. Se eliminará para recrearla.
    schtasks /delete /tn "%taskName%" /f
)
schtasks /create /tn "%taskName%" /tr "\"%taskAction%\"" /sc daily /st %customTime% /rl highest
if %errorlevel%==0 (
    echo Tarea personalizada programada correctamente.
) else (
    echo Error al crear la tarea personalizada.
)
pause
goto menu

:cancel_tasks
echo.
echo Cancelando tareas programadas (OneVeamActivate, OneVeamDeactivate, OneVeamCustom)...
schtasks /delete /tn "OneVeamActivate" /f >nul 2>&1
schtasks /delete /tn "OneVeamDeactivate" /f >nul 2>&1
schtasks /delete /tn "OneVeamCustom" /f >nul 2>&1
echo Tareas canceladas.
pause
goto menu

:salir
echo.
echo Saliendo del script...
exit /b
