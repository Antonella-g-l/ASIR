# Caso práctico: Cloud Computing y AWS

## Descripción

Caso práctico sobre conceptos fundamentales de Cloud Computing y una arquitectura básica en AWS.

## Contenidos

- Elasticidad y escalabilidad en la nube
- CAPEX y OPEX
- Modelos de despliegue: cloud, on-premises e híbrido
- Modelos de servicio: IaaS, PaaS y SaaS
- Servicios de AWS: EC2, EBS, S3, RDS, VPC e IAM
- Conceptos básicos de arquitectura cloud

## 1. Elasticidad en Cloud Computing

La elasticidad permite adaptar los recursos informáticos a la demanda real.

Por ejemplo, una tienda online puede reducir los recursos utilizados durante la mayor parte del año y aumentarlos automáticamente durante periodos de alta demanda, como Black Friday.

Esto permite evitar mantener servidores sobredimensionados cuando no son necesarios y utilizar los recursos de forma más eficiente.

## 2. CAPEX y OPEX

CAPEX representa la inversión inicial necesaria para comprar y mantener infraestructura propia, como servidores y otros equipos.

OPEX se refiere a los gastos operativos derivados del uso de recursos. En un entorno cloud, permite pagar por los recursos utilizados según la demanda.

Por ejemplo, mantener servidores propios puede suponer un coste fijo aunque no se utilice toda su capacidad, mientras que en cloud el coste puede variar según los recursos consumidos.

## 3. Cloud híbrido

Un modelo híbrido combina infraestructura propia (on-premises) con recursos de cloud.

Este enfoque permite mantener determinados sistemas o datos en la infraestructura de la empresa y utilizar servicios cloud cuando sea necesario.

Una de sus ventajas es la flexibilidad, aunque también puede aumentar la complejidad de administración, seguridad y comunicación entre ambos entornos.

## 4. IaaS, PaaS y SaaS

Los modelos de servicio cloud se diferencian principalmente por el nivel de control que mantiene el cliente sobre la infraestructura.

- **IaaS (Infrastructure as a Service):** proporciona recursos básicos como máquinas virtuales, almacenamiento y redes. El cliente mantiene mayor control sobre el sistema operativo y las aplicaciones.
- **PaaS (Platform as a Service):** proporciona una plataforma gestionada para desarrollar y desplegar aplicaciones, sin tener que administrar directamente la infraestructura.
- **SaaS (Software as a Service):** proporciona una aplicación completa gestionada por el proveedor, que el usuario utiliza directamente.

## 5. Servicios utilizados de AWS

Para plantear una arquitectura básica en AWS se pueden utilizar diferentes servicios, cada uno con una función específica:

- **EC2 (Elastic Compute Cloud):** permite ejecutar máquinas virtuales para alojar aplicaciones y servicios.
- **EBS (Elastic Block Store):** proporciona almacenamiento de bloques asociado a las instancias EC2.
- **S3 (Simple Storage Service):** permite almacenar objetos como imágenes, documentos y copias de seguridad de forma independiente de las máquinas virtuales.
- **RDS (Relational Database Service):** proporciona bases de datos relacionales gestionadas por AWS.
- **VPC (Virtual Private Cloud):** permite crear una red virtual aislada para organizar y controlar la comunicación entre los recursos.
- **IAM (Identity and Access Management):** permite gestionar usuarios, roles y permisos para controlar el acceso a los recursos de AWS.

## 6. Arquitectura propuesta

Una posible arquitectura básica podría organizar los servicios de la siguiente manera:

- La **VPC** proporciona la red virtual donde se encuentran los recursos.
- **EC2** ejecuta la aplicación.
- **EBS** proporciona almacenamiento de bloques para la instancia EC2.
- **RDS** proporciona la base de datos de la aplicación.
- **S3** almacena archivos como imágenes y copias de seguridad de forma independiente.
- **IAM** gestiona los usuarios y permisos de acceso a los recursos.

### Diagrama de arquitectura

```mermaid
flowchart LR
    U[Usuarios] --> VPC[VPC]

    VPC --> EC2[EC2<br>Aplicación]
    EC2 --> EBS[EBS<br>Almacenamiento]
    EC2 --> RDS[RDS<br>Base de datos]

    U --> S3[S3<br>Imágenes y archivos]

    IAM[IAM<br>Usuarios y permisos] -.-> VPC
    IAM -.-> EC2
    IAM -.-> S3
    IAM -.-> RDS
