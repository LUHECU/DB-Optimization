CREATE VIEW V_TotalVentasGeneros
AS
    SELECT g.name_ "GÉNERO", SUM(i.total) VENTAS, COUNT(t.trackid) "TOTAL PISTAS" FROM genre g
    INNER JOIN track t
    ON t.genreid = g.genreid
    INNER JOIN invoiceline il
    ON t.trackid = il.trackid
    INNER JOIN invoice i
    ON il.invoiceid = i.invoiceid
    GROUP BY g.name_
    ORDER BY SUM(i.total) DESC;
    
    
    
CREATE VIEW V_TotalVentasAlbunes
AS
    SELECT a.title "TITULO", SUM(i.total) VENTAS, COUNT(t.trackid) "TOTAL PISTAS" FROM album a
    INNER JOIN track t
    ON t.albumid = a.albumid
    INNER JOIN invoiceline il
    ON t.trackid = il.trackid
    INNER JOIN invoice i
    ON il.invoiceid = i.invoiceid
    GROUP BY a.title
    ORDER BY SUM(i.total) DESC;
    
CREATE VIEW V_TotalVentasArtistas
AS
    SELECT art.name_ "ARTISTA", SUM(i.total) VENTAS, COUNT(t.trackid) "TOTAL PISTAS" FROM artist art
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
    
    
    
    
    
    