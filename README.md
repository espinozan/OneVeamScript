# OneVeamScript

OneVeamScript es un script en Batch diseñado para Windows 10 que te permite gestionar de forma sencilla los servicios principales de Veeam Backup & Replication, tanto de manera inmediata como mediante programación. El script presenta un menú interactivo, permite activar o desactivar todos los servicios de Veeam y ofrece opciones para programar tareas para que se ejecuten al inicio (on logon) o a una hora personalizada. Además, incluye la funcionalidad para cancelar tareas programadas previamente.

## Características

- **Menú interactivo:**  
  Ofrece las siguientes opciones:
  - Activar o desactivar inmediatamente todos los servicios de Veeam.
  - Programar la activación o desactivación de los servicios al inicio de sesión.
  - Programar una tarea diaria personalizada (definir la hora y la acción, `activate` o `deactivate`).
  - Cancelar las tareas programadas (nombres: OneVeamActivate, OneVeamDeactivate y OneVeamCustom).
  - Salir del script.

- **Verificación de privilegios:**  
  El script verifica que se ejecute con privilegios de administrador antes de intentar modificar la configuración de los servicios o crear tareas programadas.

- **Soporte de parámetros de línea de comandos:**  
  Permite llamar al script directamente con `activate` o `deactivate` para facilitar la ejecución mediante tareas programadas.

- **Programación de tareas:**  
  Utiliza `schtasks` para crear tareas que se ejecuten al inicio (on logon) o diariamente a una hora específica, con el nivel de privilegios más alto.

## Requisitos

- **Sistema Operativo:** Windows 10 (compatible también con entornos de Server Core en pruebas, pero se recomienda usarlo en entornos de escritorio para facilitar la administración).
- **Permisos:** Debe ejecutarse como administrador.
- **Servicios de Veeam:** Se asume que los servicios de Veeam (por defecto, se incluyen los siguientes) están instalados en el equipo:
  - `VeeamBackupSvc` – Veeam Backup Service
  - `VeeamDeploySvc` – Veeam Installer Service
  - `VeeamTransportSvc` – Veeam Data Mover Service
  - `VeeamBrokerSvc` – Veeam Broker Service
  - `VeeamFilesysVssSvc` – Veeam Backup VSS Integration Service
  - `VeeamDistributionSvc` – Veeam Distribution Service
  - `VeeamNFSSvc` – Veeam vPower NFS Service

## Uso

1. **Descarga o clona el repositorio** en tu equipo:

   ```bash
   git clone https://github.com/TuUsuario/OneVeamScript.git
   ```

2. **Ejecuta el script** con privilegios de administrador:
   - Haz clic derecho sobre `OneVeamScript.bat` y selecciona "Ejecutar como administrador".
   - También puedes ejecutar el script desde una ventana de comandos abierta como administrador.

3. **Interactúa con el menú:**
   - **Opción 1:** Activa inmediatamente todos los servicios de Veeam.
   - **Opción 2:** Desactiva inmediatamente todos los servicios de Veeam.
   - **Opción 3:** Programa una tarea para activar los servicios al iniciar sesión (on logon).
   - **Opción 4:** Programa una tarea para desactivar los servicios al iniciar sesión.
   - **Opción 5:** Programa una tarea diaria personalizada. Se te solicitará especificar la acción (`activate` o `deactivate`) y la hora de ejecución en formato 24h (HH:MM).
   - **Opción 6:** Cancela todas las tareas programadas relacionadas con OneVeamScript.
   - **Opción 7:** Salir del script.

4. **Ejecución a través de tareas programadas:**  
   El script soporta parámetros de línea de comandos (`activate` o `deactivate`) para permitir su ejecución directa desde las tareas programadas sin necesidad de interactuar con el menú.

## Detalles del Script

- **Verificación de privilegios:**  
  Se utiliza el comando `openfiles` para comprobar que el script se ejecuta con derechos de administrador.

- **Gestión de servicios:**  
  Utiliza `sc config` y `sc start` / `sc stop` para cambiar el modo de inicio de los servicios y para iniciarlos o detenerlos según la acción seleccionada.

- **Programación de tareas:**  
  Utiliza `schtasks` para crear tareas con nombres fijos (OneVeamActivate, OneVeamDeactivate y OneVeamCustom), eliminando tareas existentes con esos nombres antes de crear nuevas.

- **Soporte de parámetros:**  
  Si el script se ejecuta con `activate` o `deactivate` como argumento, realizará la acción correspondiente sin mostrar el menú, facilitando la integración con tareas programadas.

## Contribuciones

¡Las contribuciones son bienvenidas! Si deseas mejorar el script, agregar nuevas funcionalidades o corregir errores, por favor abre un _issue_ o envía un _pull request_.

## Licencia

Este proyecto se distribuye bajo la [MIT License](LICENSE).

---

_Desarrollado por Nahuel Espinoza – Ingeniero en Software y Sistemas experto en Windows y servicios Veeam._
