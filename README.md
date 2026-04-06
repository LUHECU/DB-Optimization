# ⚡ DB-Optimization — Chinook Database Performance Project

A comprehensive Oracle database optimization project applied over the open-source **Chinook** sample database, featuring indexes, table partitioning, CRUD procedures, triggers, functions, and complex analytical views with execution plan analysis.

> 📄 **Full technical documentation is available in [`Documentación.pdf`](./Documentación.pdf)**

---

## 🇺🇸 English

### About

This project applies a full suite of Oracle performance optimization and PL/SQL development techniques on top of the [Chinook](https://github.com/lerocha/chinook-database) sample database — a widely used open-source dataset that models a digital music store (artists, albums, tracks, invoices, customers, employees, and playlists).

> ⚠️ **Attribution:** The original Chinook database schema and data are open-source and were **not created by the author**. All optimization work — indexes, partitioning, CRUD procedures, triggers, functions, and views — are **original contributions** made as part of this project.

The goal was to analyze and improve query performance using execution plans (`EXPLAIN PLAN`), strategic indexing, composite table partitioning, materialized views, and a rich PL/SQL layer covering stored procedures, validation triggers, and reusable functions.

### ✨ What Was Built

- 🗂️ **Indexes** — Strategic indexes across all major Chinook tables to accelerate frequent queries
- 📦 **Table Partitioning** — Two partitioned tables using Composite (Range + List) and Hash strategies with execution plan comparisons
- 🔧 **CRUD Stored Procedures** — Full insert, update, delete, and read procedures for all Chinook entities
- 🔒 **Validation Triggers** — Business rule enforcement at the database level
- 🧮 **User-defined Functions** — Reusable utility functions for employee analytics and unit conversions
- 📊 **Analytical Views** — 12 regular views and 2 materialized views for sales reporting and entity summaries
- 📈 **Execution Plan Analysis** — Every view and partition includes `EXPLAIN PLAN` output to demonstrate performance gains
- 📄 **Technical Documentation** — Full project documentation in PDF and DOCX format

### 🗄️ Base Schema: Chinook Database

The Chinook database models a digital music store with the following tables: `Artist`, `Album`, `Track`, `Genre`, `MediaType`, `Playlist`, `PlaylistTrack`, `Customer`, `Employee`, `Invoice`, and `InvoiceLine`.

### 📂 Repository Structure

| File | Description |
|---|---|
| `Chinook.sql` | Original Chinook database schema and seed data |
| `CRUD CHINOOK.sql` | Stored procedures for full CRUD on all Chinook tables |
| `Indices y particion tabla INVOICE.sql` | All indexes + composite and hash partitioned tables |
| `TRIGGERS.sql` | Validation triggers with business rule enforcement |
| `Funciones.sql` | User-defined functions for analytics and conversions |
| `Vistas__V2.sql` | 12 analytical views + 2 materialized views with execution plans |
| `VistasdeVentasTotales.sql` | Additional total-sales views |
| `PROYECTO_BDII.sql` | Main project script |
| `Documentación.pdf` | Full technical documentation (PDF) |
| `Documentación.docx` | Full technical documentation (Word) |

### 📌 Indexes

Indexes were created on all high-traffic columns across the Chinook tables to speed up joins, filters, and lookups:

| Table | Indexes Created |
|---|---|
| `Album` | `idx_Album_ArtistId` |
| `Customer` | Composite on `(LastName, FirstName)`, unique on `Email`, composite on `(City, State_, Country)` |
| `Employee` | Composite on `(LastName, FirstName)`, `ReportsTo`, `HireDate` |
| `Invoice` | `CustomerId`, `InvoiceDate` |
| `InvoiceLine` | `InvoiceId`, `TrackId` |
| `PlaylistTrack` | `TrackId` |
| `Track` | `AlbumId`, `MediaTypeId`, `GenreId`, `Composer` |
| `INVOICE_PARTICIONADA` | `InvoiceDate` |
| `PLAYLISTTRACK_PARTICIONADA` | `TrackId` |

### 📦 Table Partitioning

Two partitioned tables were created to demonstrate partition pruning and improved query performance, each compared against the original table using `EXPLAIN PLAN`.

**`INVOICE_PARTICIONADA` — Composite Partitioning (Range + List)**
- Partitioned by `InvoiceDate` range into yearly partitions: `P_2009` through `P_2013`
- Sub-partitioned by `BillingCountry` using a LIST of 24 countries (Argentina, Australia, Brazil, Canada, USA, etc.)
- Includes `EXPLAIN PLAN` comparison between the original `INVOICE` and the partitioned version for date-range queries

**`PLAYLISTTRACK_PARTICIONADA` — Hash Partitioning**
- Partitioned by `HASH(TrackId)` into 4 equal buckets
- Includes `EXPLAIN PLAN` comparison for lookup queries by `TrackId`

### 🔒 Triggers

All triggers were created as `BEFORE INSERT OR UPDATE` to enforce business rules at the database level:

| Trigger | Table | Error Code | Rule |
|---|---|---|---|
| `TR_ValidaFechaInvoice` | `Invoice` | `-20001` | Invoice date cannot be in the past |
| `TR_EdadEmployee` | `Employee` | `-20002` | Employee must be 18 or older (calls `fn_calcular_edad`) |
| `TR_ValidaNegativosTrack` | `Track` | `-20003/-20004/-20005` | Milliseconds, bytes, and unit price cannot be negative |
| `TR_ValidaNegativosInvoiceline` | `InvoiceLine` | `-20006/-20007` | Unit price and quantity cannot be negative |

### 🧮 Functions

| Function | Description |
|---|---|
| `fn_top_empleado` | Returns the full name of the top-selling employee (by total invoice sum) |
| `fn_calcular_edad(p_birthdate)` | Calculates a person's age in years from a birth date |
| `fn_calcular_tiempo_trabajado(p_hiredate)` | Calculates years of service for an employee |
| `fn_convertir_bytes(p_bytes)` | Converts bytes to megabytes (MB) |
| `fn_calcular_segundos(p_milliseconds)` | Converts milliseconds to seconds |

> Note: `fn_calcular_edad` is also used directly by the `TR_EdadEmployee` trigger for age validation.

### 📊 Views

**Analytical Views (`Vistas__V2.sql`)**

| View | Description |
|---|---|
| `V_TotalVentasGeneros` | Total sales and tracks sold grouped by music genre |
| `V_TotalVentasAlbunes` | Total sales and tracks sold grouped by album |
| `V_TotalVentasArtistas` | Total sales and tracks sold grouped by artist |
| `V_TotalVentasEmpleados` | Total sales and tracks sold grouped by support employee |
| `V_VentasPorAnho` | Total invoices and revenue grouped by year |
| `V_TipoArchivoMasComprado` | Most purchased media types with track and purchase counts |
| `Vista_Playlist` | Playlists with their total track count |
| `Vista_Invoice` | Invoices with full customer details and track quantity |
| `Vista_Genre` | Genres with track and album counts |
| `Vista_Employee` | Employees with supervisor name and number of customers supported |
| `Vista_Artist` | Artists with album count and total tracks |
| `Vista_Album` | Albums with artist name and primary genre |

**Materialized Views**

| Materialized View | Description |
|---|---|
| `MV_PlaylistTrack` | Pre-computed playlist-track join with album details (faster playlist queries) |
| `MV_Track` | Pre-computed track info with genre, media type, duration in seconds (`fn_calcular_segundos`), and size in MB (`fn_convertir_bytes`) |

> Every view includes an `EXPLAIN PLAN` block to measure and document query execution performance.

### ⚙️ Prerequisites

- **Oracle Database** (11g or later recommended)
- **Oracle SQL Developer** or **SQL*Plus**
- A DBA-level user to run the initial schema setup

### 🚀 Getting Started

```sql
-- 1. Run the base Chinook schema first
@Chinook.sql

-- 2. Create all indexes and partitioned tables
@"Indices y particion tabla INVOICE.sql"

-- 3. Create CRUD stored procedures
@"CRUD CHINOOK.sql"

-- 4. Create user-defined functions (required before triggers)
@Funciones.sql

-- 5. Create validation triggers
@TRIGGERS.sql

-- 6. Create all views and materialized views
@Vistas__V2.sql
@VistasdeVentasTotales.sql

-- 7. Run main project script
@PROYECTO_BDII.sql
```

---

## 🇪🇸 Español

### Acerca del proyecto

Este proyecto aplica un conjunto completo de técnicas de optimización de rendimiento y desarrollo PL/SQL sobre la base de datos de muestra [Chinook](https://github.com/lerocha/chinook-database) — un dataset open-source ampliamente utilizado que modela una tienda de música digital (artistas, álbumes, pistas, facturas, clientes, empleados y listas de reproducción).

> ⚠️ **Atribución:** El esquema y los datos originales de la base de datos Chinook son de código abierto y **no fueron creados por el autor**. Todo el trabajo de optimización — índices, particionado, procedimientos CRUD, triggers, funciones y vistas — son **contribuciones originales** realizadas como parte de este proyecto.

El objetivo fue analizar y mejorar el rendimiento de las consultas mediante planes de ejecución (`EXPLAIN PLAN`), indexación estratégica, particionado compuesto de tablas, vistas materializadas y una capa PL/SQL completa con procedimientos almacenados, triggers de validación y funciones reutilizables.

### ✨ Qué se construyó

- 🗂️ **Índices** — Índices estratégicos en todas las tablas principales de Chinook para acelerar consultas frecuentes
- 📦 **Particionado de Tablas** — Dos tablas particionadas con estrategias Compuesta (Rango + Lista) y Hash, con comparaciones de planes de ejecución
- 🔧 **Procedimientos CRUD** — Procedimientos completos de inserción, actualización, eliminación y lectura para todas las entidades de Chinook
- 🔒 **Triggers de Validación** — Aplicación de reglas de negocio a nivel de base de datos
- 🧮 **Funciones de Usuario** — Funciones utilitarias reutilizables para análisis de empleados y conversiones de unidades
- 📊 **Vistas Analíticas** — 12 vistas regulares y 2 vistas materializadas para reportes de ventas y resúmenes de entidades
- 📈 **Análisis de Planes de Ejecución** — Cada vista y partición incluye salida de `EXPLAIN PLAN` para demostrar mejoras de rendimiento
- 📄 **Documentación Técnica** — Documentación completa del proyecto en formato PDF y DOCX

### 🗄️ Esquema Base: Base de Datos Chinook

La base de datos Chinook modela una tienda de música digital con las siguientes tablas: `Artist`, `Album`, `Track`, `Genre`, `MediaType`, `Playlist`, `PlaylistTrack`, `Customer`, `Employee`, `Invoice` e `InvoiceLine`.

### 📂 Estructura del Repositorio

| Archivo | Descripción |
|---|---|
| `Chinook.sql` | Esquema original de Chinook y datos de ejemplo |
| `CRUD CHINOOK.sql` | Procedimientos almacenados CRUD completos para todas las tablas |
| `Indices y particion tabla INVOICE.sql` | Todos los índices + tablas particionadas compuesta y hash |
| `TRIGGERS.sql` | Triggers de validación con aplicación de reglas de negocio |
| `Funciones.sql` | Funciones de usuario para análisis y conversiones |
| `Vistas__V2.sql` | 12 vistas analíticas + 2 vistas materializadas con planes de ejecución |
| `VistasdeVentasTotales.sql` | Vistas adicionales de ventas totales |
| `PROYECTO_BDII.sql` | Script principal del proyecto |
| `Documentación.pdf` | Documentación técnica completa (PDF) |
| `Documentación.docx` | Documentación técnica completa (Word) |

### 📌 Índices

Se crearon índices en todas las columnas de alto tráfico de las tablas Chinook para acelerar JOINs, filtros y búsquedas:

| Tabla | Índices Creados |
|---|---|
| `Album` | `idx_Album_ArtistId` |
| `Customer` | Compuesto en `(LastName, FirstName)`, único en `Email`, compuesto en `(City, State_, Country)` |
| `Employee` | Compuesto en `(LastName, FirstName)`, `ReportsTo`, `HireDate` |
| `Invoice` | `CustomerId`, `InvoiceDate` |
| `InvoiceLine` | `InvoiceId`, `TrackId` |
| `PlaylistTrack` | `TrackId` |
| `Track` | `AlbumId`, `MediaTypeId`, `GenreId`, `Composer` |
| `INVOICE_PARTICIONADA` | `InvoiceDate` |
| `PLAYLISTTRACK_PARTICIONADA` | `TrackId` |

### 📦 Particionado de Tablas

Se crearon dos tablas particionadas para demostrar la poda de particiones y la mejora en el rendimiento de consultas, cada una comparada con la tabla original usando `EXPLAIN PLAN`.

**`INVOICE_PARTICIONADA` — Particionado Compuesto (Rango + Lista)**
- Particionada por rango de `InvoiceDate` en particiones anuales: `P_2009` a `P_2013`
- Sub-particionada por `BillingCountry` usando una LISTA de 24 países (Argentina, Australia, Brasil, Canadá, USA, etc.)
- Incluye comparación de `EXPLAIN PLAN` entre la tabla `INVOICE` original y la versión particionada para consultas por rango de fechas

**`PLAYLISTTRACK_PARTICIONADA` — Particionado Hash**
- Particionada por `HASH(TrackId)` en 4 cubetas iguales
- Incluye comparación de `EXPLAIN PLAN` para consultas de búsqueda por `TrackId`

### 🔒 Triggers

Todos los triggers se crearon como `BEFORE INSERT OR UPDATE` para aplicar reglas de negocio a nivel de base de datos:

| Trigger | Tabla | Código Error | Regla |
|---|---|---|---|
| `TR_ValidaFechaInvoice` | `Invoice` | `-20001` | La fecha de factura no puede ser anterior a la actual |
| `TR_EdadEmployee` | `Employee` | `-20002` | El empleado debe ser mayor de 18 años (llama a `fn_calcular_edad`) |
| `TR_ValidaNegativosTrack` | `Track` | `-20003/-20004/-20005` | Milisegundos, bytes y precio unitario no pueden ser negativos |
| `TR_ValidaNegativosInvoiceline` | `InvoiceLine` | `-20006/-20007` | El precio unitario y la cantidad no pueden ser negativos |

### 🧮 Funciones

| Función | Descripción |
|---|---|
| `fn_top_empleado` | Retorna el nombre completo del empleado con más ventas (por suma total de facturas) |
| `fn_calcular_edad(p_birthdate)` | Calcula la edad de una persona en años a partir de su fecha de nacimiento |
| `fn_calcular_tiempo_trabajado(p_hiredate)` | Calcula los años de servicio de un empleado |
| `fn_convertir_bytes(p_bytes)` | Convierte bytes a megabytes (MB) |
| `fn_calcular_segundos(p_milliseconds)` | Convierte milisegundos a segundos |

> Nota: `fn_calcular_edad` también es utilizada directamente por el trigger `TR_EdadEmployee` para la validación de edad.

### 📊 Vistas

**Vistas Analíticas (`Vistas__V2.sql`)**

| Vista | Descripción |
|---|---|
| `V_TotalVentasGeneros` | Ventas totales y pistas vendidas agrupadas por género musical |
| `V_TotalVentasAlbunes` | Ventas totales y pistas vendidas agrupadas por álbum |
| `V_TotalVentasArtistas` | Ventas totales y pistas vendidas agrupadas por artista |
| `V_TotalVentasEmpleados` | Ventas totales y pistas vendidas agrupadas por empleado de soporte |
| `V_VentasPorAnho` | Total de facturas e ingresos agrupados por año |
| `V_TipoArchivoMasComprado` | Tipos de medio más comprados con conteos de pistas y compras |
| `Vista_Playlist` | Listas de reproducción con su cantidad total de pistas |
| `Vista_Invoice` | Facturas con detalles completos del cliente y cantidad de pistas |
| `Vista_Genre` | Géneros con conteos de pistas y álbumes |
| `Vista_Employee` | Empleados con nombre del supervisor y número de clientes atendidos |
| `Vista_Artist` | Artistas con conteo de álbumes y total de pistas |
| `Vista_Album` | Álbumes con nombre del artista y género principal |

**Vistas Materializadas**

| Vista Materializada | Descripción |
|---|---|
| `MV_PlaylistTrack` | JOIN pre-calculado de playlist-pista con detalles del álbum (consultas de playlist más rápidas) |
| `MV_Track` | Información de pistas pre-calculada con género, tipo de medio, duración en segundos (`fn_calcular_segundos`) y tamaño en MB (`fn_convertir_bytes`) |

> Cada vista incluye un bloque `EXPLAIN PLAN` para medir y documentar el rendimiento de ejecución de las consultas.

### ⚙️ Requisitos Previos

- **Oracle Database** (se recomienda 11g o superior)
- **Oracle SQL Developer** o **SQL*Plus**
- Un usuario con privilegios DBA para ejecutar la configuración inicial del esquema

### 🚀 Primeros Pasos

```sql
-- 1. Ejecutar primero el esquema base de Chinook
@Chinook.sql

-- 2. Crear todos los índices y tablas particionadas
@"Indices y particion tabla INVOICE.sql"

-- 3. Crear los procedimientos almacenados CRUD
@"CRUD CHINOOK.sql"

-- 4. Crear las funciones de usuario (requeridas antes de los triggers)
@Funciones.sql

-- 5. Crear los triggers de validación
@TRIGGERS.sql

-- 6. Crear todas las vistas y vistas materializadas
@Vistas__V2.sql
@VistasdeVentasTotales.sql

-- 7. Ejecutar el script principal del proyecto
@PROYECTO_BDII.sql
```

---

<div align="center">
  <sub>Built with ❤️ by <a href="https://github.com/LUHECU">LUHECU</a> — Based on the open-source <a href="https://github.com/lerocha/chinook-database">Chinook Database</a></sub>
</div>
