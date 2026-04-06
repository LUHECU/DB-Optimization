/*
Vista que nos muestra el total de ventas obtenidas
por genero
*/
CREATE OR REPLACE VIEW V_TotalVentasGeneros
AS
SELECT g.name_ "G?NERO", 
    SUM(i.total) VENTAS, 
    COUNT(t.trackid) "TOTAL PISTAS VENDIDAS" 
FROM genre g
INNER JOIN track t
ON t.genreid = g.genreid
INNER JOIN invoiceline il
ON t.trackid = il.trackid
INNER JOIN invoice i
ON il.invoiceid = i.invoiceid
GROUP BY g.name_
ORDER BY SUM(i.total) DESC;
/
--Evidencia
--Estadisticas de rendimiento en la vista 
EXPLAIN PLAN FOR
SELECT "G?NERO" ,
VENTAS ,
"TOTAL PISTAS VENDIDAS"  FROM V_TotalVentasGeneros;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
------------------------------------------------------------------------------------

    
    
/*
Vista que nos muestra el total de ventas obtenidas
por Album
*/    
CREATE OR REPLACE VIEW V_TotalVentasAlbunes
AS
SELECT 
    a.title "TITULO", 
    SUM(i.total) VENTAS, 
    COUNT(t.trackid) "TOTAL PISTAS" 
FROM album a
INNER JOIN track t
ON t.albumid = a.albumid
INNER JOIN invoiceline il
ON t.trackid = il.trackid
INNER JOIN invoice i
ON il.invoiceid = i.invoiceid
GROUP BY a.title
ORDER BY SUM(i.total) DESC;
/
--Evidencia
--Estadisticas de rendimiento en la vista 
EXPLAIN PLAN FOR
SELECT TITULO ,
VENTAS ,
"TOTAL PISTAS"  FROM V_TotalVentasAlbunes;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
------------------------------------------------------------------------------------



/*
Vista que nos muestra el total de ventas obtenidas
por Artista
*/    
CREATE OR REPLACE VIEW V_TotalVentasArtistas
AS
SELECT 
    art.name_ "ARTISTA", 
    SUM(i.total) VENTAS, 
    COUNT(t.trackid) "TOTAL PISTAS" 
FROM artist art
INNER JOIN album a
ON art.artistid = a.artistid
INNER JOIN track t
ON t.albumid = a.albumid
INNER JOIN invoiceline il
ON t.trackid = il.trackid
INNER JOIN invoice i
ON il.invoiceid = i.invoiceid
GROUP BY art.name_
ORDER BY SUM(i.total) DESC;
/
--Evidencia
--Estadisticas de rendimiento en la vista 
EXPLAIN PLAN FOR
SELECT "ARTISTA", 
       VENTAS, 
       "TOTAL PISTAS" 
FROM V_TotalVentasArtistas;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
------------------------------------------------------------------------------------



/*
Vista que nos muestra el total de ventas obtenidas
por Empleado
*/    
CREATE OR REPLACE VIEW V_TotalVentasEmpleados
AS
SELECT 
    e.FirstName || ' ' || e.LastName "Empleado",  
    SUM(i.Total) "Ventas",  
    COUNT(il.TrackId) "total pistas Vendidas"
FROM Employee e
INNER JOIN Customer c
ON e.EmployeeId = c.SupportRepId
INNER JOIN Invoice i
ON c.CustomerId = i.CustomerId
INNER JOIN InvoiceLine il
ON i.InvoiceId = il.InvoiceId
GROUP BY e.FirstName, e.LastName
ORDER BY SUM(i.Total) DESC;
/
--Evidencia
--Estadisticas de rendimiento en la vista 
EXPLAIN PLAN FOR
SELECT "Empleado", 
       "Ventas", 
       "total pistas Vendidas" 
FROM V_TotalVentasEmpleados;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
------------------------------------------------------------------------------------



/*
Vista que nos muestra el total de ventas obtenidas
por Año y la cantidad de tracks vendidas
*/
CREATE OR REPLACE VIEW V_VentasPorAnho
AS
SELECT 
    EXTRACT(YEAR FROM InvoiceDate) AS "AÑO",COUNT(InvoiceId) AS "TOTAL_VENTAS",
    SUM(Total) AS "TOTAL_RECAUDADO" FROM Invoice
GROUP BY EXTRACT(YEAR FROM InvoiceDate)
ORDER BY EXTRACT(YEAR FROM InvoiceDate);
/
--Evidencia
--Estadisticas de rendimiento en la vista 
EXPLAIN PLAN FOR
SELECT "AÑO", 
       "TOTAL_VENTAS", 
       "TOTAL_RECAUDADO" 
FROM V_VentasPorAnho;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
------------------------------------------------------------------------------------



/*
Vista que nos muestra eual es el tipo de media que*
mas se ha vendido
*/
CREATE OR REPLACE VIEW V_TipoArchivoMasComprado
AS
SELECT 
    mt.Name_ AS "Tipo Archivo",
    COUNT(t.TrackId) AS "Contenido Existente",
    COUNT(il.InvoiceLineId) AS "Total Comprado"
FROM MediaType mt
LEFT JOIN 
Track t ON mt.MediaTypeId = t.MediaTypeId
LEFT JOIN InvoiceLine il ON t.TrackId = il.TrackId
GROUP BY mt.Name_
ORDER BY COUNT(il.InvoiceLineId) DESC;
/
--Evidencia
--Estadisticas de rendimiento en la vista 
EXPLAIN PLAN FOR
SELECT "Tipo Archivo", 
       "Contenido Existente", 
       "Total Comprado" 
FROM V_TipoArchivoMasComprado;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
------------------------------------------------------------------------------------
 
 
/*
Vista creada para mostrar informaci?n de la lista de 
reproducci?n junto con el n?mero de pistas en cada lista
*/
CREATE OR REPLACE VIEW Vista_Playlist AS 
SELECT 
    p.PlaylistId,
    p.Name_ AS NombredePlaylist,
    NVL(COUNT(pt.TrackId), 0) AS NumerodeTracks
FROM 
    Playlist p
LEFT JOIN 
    PlaylistTrack pt ON p.PlaylistId = pt.PlaylistId
GROUP BY 
    p.PlaylistId, p.Name_;
 /
 --Evidencia
--Estadisticas de rendimiento en la vista 
EXPLAIN PLAN FOR
SELECT PlaylistId, 
       NombredePlaylist, 
       NumerodeTracks 
FROM Vista_Playlist;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
------------------------------------------------------------------------------------   


/*
 Mostrar una factura con los detalles del cliente
*/
CREATE OR REPLACE VIEW Vista_Invoice AS 
SELECT 
    i.InvoiceId,
    i.InvoiceDate,
    c.FirstName || ' ' || c.LastName CustomerNombre,
    c.Email,
    SUM(i.total) Total,
    SUM(il.Quantity) "Cantidad Pistas"
FROM 
    Invoice i
JOIN 
    Customer c ON i.CustomerId = c.CustomerId
JOIN 
    InvoiceLine il ON i.InvoiceId = il.InvoiceId
GROUP BY i.InvoiceId,i.InvoiceDate,c.firstname,c.lastname, c.Email;
/
--Evidencia
--Estadisticas de rendimiento en la vista 
EXPLAIN PLAN FOR
SELECT InvoiceId, 
       InvoiceDate, 
       CustomerNombre, 
       Email, 
       Total, 
       "Cantidad Pistas" 
FROM Vista_Invoice;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
------------------------------------------------------------------------------------  


/*
 Muestra informaci?n del g?nero junto con el 
 n?mero de pistas y existentes ?lbumes asociados a ese g?nero
*/
CREATE OR REPLACE VIEW Vista_Genre AS
SELECT 
    g.GenreId,
    g.Name_ AS Genero,
    NVL(COUNT(DISTINCT t.TrackId), 0) AS Nuemrodetracks,
    NVL(COUNT(DISTINCT a.AlbumId), 0) AS Numerodealbums
FROM 
    Genre g
LEFT JOIN 
    Track t ON g.GenreId = t.GenreId
LEFT JOIN 
    Album a ON t.AlbumId = a.AlbumId
GROUP BY 
    g.GenreId, g.Name_;
/
--Evidencia
--Estadisticas de rendimiento en la vista 
EXPLAIN PLAN FOR
SELECT GenreId, 
       Genero, 
       Nuemrodetracks, 
       Numerodealbums 
FROM Vista_Genre;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
------------------------------------------------------------------------------------    


/*
 Vista para mostrar informaci?n del empleado, incluido el 
 nombre de su supervisor y el n?mero de clientes que soporta
*/
CREATE OR REPLACE VIEW Vista_Employee AS 
SELECT 
    e.EmployeeId,
    e.FirstName || ' ' || e.LastName AS EmployeeNombre,
    e.Title,
    s.FirstName || ' ' || s.LastName AS SupervisorNombre,
    NVL(COUNT(c.CustomerId), 0) AS Clientesatendidos
FROM 
    Employee e
LEFT JOIN 
    Employee s ON e.ReportsTo = s.EmployeeId
LEFT JOIN 
    Customer c ON e.EmployeeId = c.SupportRepId
GROUP BY 
    e.EmployeeId, e.FirstName, e.LastName, e.Title, s.FirstName, s.LastName
ORDER BY COUNT(c.CustomerId) DESC;
/
--Evidencia
--Estadisticas de rendimiento en la vista 
EXPLAIN PLAN FOR
SELECT EmployeeId, 
       EmployeeNombre, 
       Title, 
       SupervisorNombre, 
       Clientesatendidos 
FROM Vista_Employee;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
------------------------------------------------------------------------------------


/*
 Vista que muestra la informaci?n del artista sobre el 
 n?mero de ?lbumes y el n?mero de canciones que tienen
*/
CREATE OR REPLACE VIEW Vista_Artist AS
SELECT 
    ar.ArtistId,
    ar.Name_ AS "Nombre del artista",
    (SELECT COUNT(DISTINCT a.AlbumId) 
     FROM Album a 
     WHERE a.ArtistId = ar.ArtistId) AS Numerodealbums,
    (SELECT COUNT(t.TrackId)
     FROM Track t
     JOIN Album a ON t.AlbumId = a.AlbumId
     WHERE a.ArtistId = ar.ArtistId) AS NumerodeTracks
FROM 
    Artist ar;
/
--Evidencia
--Estadisticas de rendimiento en la vista 
EXPLAIN PLAN FOR
SELECT "Nombre del artista", 
       Numerodealbums, 
       NumerodeTracks 
FROM Vista_Artist;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
------------------------------------------------------------------------------------    


/*
 Vista para mostrar informaci?n del ?lbum junto con el 
 nombre del artista y el g?nero principal de las pistas en el ?lbum
*/
CREATE OR REPLACE VIEW Vista_Album AS 
SELECT 
    a.AlbumId,
    a.Title AS "Titulo de album",
    ar.Name_ AS "Nombre del artista",
    g.Name_ AS Genero
FROM 
    Album a
JOIN 
    Artist ar ON a.ArtistId = ar.ArtistId
LEFT JOIN 
    (SELECT t.AlbumId, g.Name_
     FROM Track t
     JOIN Genre g ON t.GenreId = g.GenreId
     GROUP BY t.AlbumId, g.Name_) g
ON a.AlbumId = g.AlbumId;
/
--Evidencia
--Estadisticas de rendimiento en la vista 
EXPLAIN PLAN FOR
SELECT "Titulo de album", 
       "Nombre del artista", 
       Genero 
FROM Vista_Album;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
------------------------------------------------------------------------------------


--Vistas Materializadas


/*
Muestra la informaci?n de las pistas en las listas de reproducci?n, 
incluyendo el ?lbum asociado
*/
CREATE MATERIALIZED VIEW MV_PlaylistTrack AS 
SELECT 
    pt.PlaylistId,
    p.Name_ AS NombredePlaylist,
    pt.TrackId,
    t.Name_ AS NombredeTrack,
    a.Title AS Titulodealbum
FROM 
    PlaylistTrack pt
JOIN 
    Playlist p ON pt.PlaylistId = p.PlaylistId
JOIN 
    Track t ON pt.TrackId = t.TrackId
LEFT JOIN 
    Album a ON t.AlbumId = a.AlbumId;
/
--Evidencia
--Estadisticas de rendimiento en la vista 
EXPLAIN PLAN FOR
SELECT PlaylistId, 
    NombredePlaylist, 
    TrackId, 
    NombredeTrack, 
    Titulodealbum 
FROM MV_PlaylistTrack;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
------------------------------------------------------------------------------------    


/*
Muestra informaci?n de las pistas junto con el ?lbum, 
g?nero y tipo de medio asociados
*/
CREATE MATERIALIZED VIEW MV_Track AS 
SELECT 
    t.TrackId,
    t.Name_ AS NombredeTrack,
    g.Name_ AS Nombregenero,
    m.Name_ AS NombredeMediatype,
    t.Composer,
    fn_calcular_segundos(milliseconds) Segundos,
    fn_convertir_bytes(t.bytes) MB
FROM 
    Track t
LEFT JOIN 
    Album a ON t.AlbumId = a.AlbumId
LEFT JOIN 
    Genre g ON t.GenreId = g.GenreId
LEFT JOIN 
    MediaType m ON t.MediaTypeId = m.MediaTypeId
ORDER BY t.trackid ASC;
/
--Evidencia
--Estadisticas de rendimiento en la vista 
EXPLAIN PLAN FOR
SELECT TRACKID ,
    NOMBREDETRACK ,
    NOMBREGENERO ,
    NOMBREDEMEDIATYPE ,
    COMPOSER 
FROM MV_Track;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
------------------------------------------------------------------------------------   


