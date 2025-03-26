# OneVeamScript

OneVeamScript es un script en Batch diseñado para Windows 10 que te permite activar o desactivar de forma sencilla los servicios principales de Veeam Backup & Replication. El script presenta un menú interactivo y requiere ejecutarse con privilegios de administrador.

## Características

- **Menú interactivo:** Ofrece opciones para activar todos los servicios de Veeam, desactivarlos o salir del script.
- **Verificación de privilegios:** Comprueba que se ejecute con permisos de administrador antes de realizar cambios.
- **Gestión de servicios:** Configura y controla el estado de los siguientes servicios de Veeam:
  - `VeeamBackupSvc` – Veeam Backup Service
  - `VeeamDeploySvc` – Veeam Installer Service
  - `VeeamTransportSvc` – Veeam Data Mover Service
  - `VeeamBrokerSvc` – Veeam Broker Service
  - `VeeamFilesysVssSvc` – Veeam Backup VSS Integration Service
  - `VeeamDistributionSvc` – Veeam Distribution Service
  - `VeeamNFSSvc` – Veeam vPower NFS Service

## Requisitos

- **Sistema Operativo:** Windows 10 (compatible con Windows Server Core en entornos de prueba, aunque se recomienda su uso en entornos de escritorio).
- **Permisos:** Debe ejecutarse como administrador para poder modificar la configuración de los servicios.
- **Servicios de Veeam:** Se asume que los servicios de Veeam están instalados en el equipo.

## Uso

1. **Descarga o clona el repositorio** en tu equipo:

   ```bash
   git clone https://github.com/TuUsuario/OneVeamScript.git
   ```

2. **Ejecuta el script** con privilegios de administrador:

   - Haz clic derecho sobre `OneVeamScript.bat` y selecciona "Ejecutar como administrador".

3. **Selecciona la opción deseada** en el menú:
   - **1:** Activar todos los servicios de Veeam.
   - **2:** Desactivar todos los servicios de Veeam.
   - **3:** Salir del script.

## Detalles del Script

El script realiza lo siguiente:

- **Verificación de privilegios:** Utiliza `openfiles` para comprobar si el script se ejecuta con derechos de administrador.
- **Menú interactivo:** Muestra un menú para seleccionar la acción deseada.
- **Activar servicios:** Configura los servicios para que se inicien automáticamente y los arranca.
- **Desactivar servicios:** Detiene los servicios y los configura para que no se inicien (estado "disabled").

## Contribuciones

¡Las contribuciones son bienvenidas! Si tienes alguna mejora, corrección o sugerencia, por favor abre un _issue_ o envía un _pull request_.

## Licencia

Este proyecto se distribuye bajo la [MIT License](LICENSE).

---

_Desarrollado por Nahuel Espinoza – Ingeniero en Software y Sistemas experto en Windows y servicios Veeam._
