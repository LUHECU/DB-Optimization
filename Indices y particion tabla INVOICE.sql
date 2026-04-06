/*
Creamos indices para las tablas y las columnas que son mas utilizadas 
*/
--Para la tabla Album
CREATE INDEX idx_Album_ArtistId ON Album (ArtistId);
--Para la tabla Customer
CREATE INDEX idx_Customer_LastName_FirstName ON Customer (LastName, FirstName);
CREATE UNIQUE INDEX idx_Customer_Email ON Customer (Email);
CREATE INDEX idx_Customer_City_State_Country ON Customer (City, State_, Country);
--Para la tabla Employee
CREATE INDEX idx_Employee_LastName_FirstName ON Employee (LastName, FirstName);
CREATE INDEX idx_Employee_ReportsTo ON Employee (ReportsTo);
CREATE INDEX idx_Employee_HireDate ON Employee (HireDate);
--Para la tabla Invoice
CREATE INDEX idx_Invoice_CustomerId ON Invoice (CustomerId);
CREATE INDEX idx_Invoice_InvoiceDate ON Invoice (InvoiceDate);
--Para la tabla InvoiceLine
CREATE INDEX idx_InvoiceLine_InvoiceId ON InvoiceLine (InvoiceId);
CREATE INDEX idx_InvoiceLine_TrackId ON InvoiceLine (TrackId);
--Para la tabla PlaylistTrack
CREATE INDEX idx_PlaylistTrack_TrackId ON PlaylistTrack (TrackId);
--Para la tabla Track
CREATE INDEX idx_Track_AlbumId ON Track (AlbumId);
CREATE INDEX idx_Track_MediaTypeId ON Track (MediaTypeId);
CREATE INDEX idx_Track_GenreId ON Track (GenreId);
CREATE INDEX idx_Track_Composer ON Track (Composer);
--Para la tabla INVOICE_PARTICIONADA
CREATE INDEX idx_invoice_Particion_Invoicedate  ON INVOICE_PARTICIONADA (INVOICEDATE);
--Para la tabla PLAYLISTTRACK_PARTICIONADA
CREATE INDEX idx_PlaylistTrack_Particion_Trackid  ON PLAYLISTTRACK_PARTICIONADA (TRACKID);

--INVOICE_PARTICIONADA Ccon el metodo de Particionado Composite EN rango de fechas NVOICEDATE Y 
--con subparticion por BILLINGCOUNTRY

CREATE TABLE INVOICE_PARTICIONADA (
    INVOICEID NUMBER,
    CUSTOMERID NUMBER,
    INVOICEDATE DATE,
    BILLINGADDRESS VARCHAR2(70 BYTE),
    BILLINGCITY VARCHAR2(40 BYTE),
    BILLINGSTATE_ VARCHAR2(40 BYTE),
    BILLINGCOUNTRY VARCHAR2(40 BYTE),
    BILLINGPOSTALCODE VARCHAR2(10 BYTE),
    TOTAL NUMBER(10,2)
)
PARTITION BY RANGE (INVOICEDATE)
SUBPARTITION BY LIST (BILLINGCOUNTRY)
SUBPARTITION TEMPLATE (
    SUBPARTITION ventas_Argentina VALUES ('Argentina'),
    SUBPARTITION ventas_Australia VALUES ('Australia'),
    SUBPARTITION ventas_Austria VALUES ('Austria'),
    SUBPARTITION ventas_Belgium VALUES ('Belgium'),
    SUBPARTITION ventas_Brazil VALUES ('Brazil'),
    SUBPARTITION ventas_Canada VALUES ('Canada'),
    SUBPARTITION ventas_Chile VALUES ('Chile'),
    SUBPARTITION ventas_Czech_Republic VALUES ('Czech Republic'),
    SUBPARTITION ventas_Denmark VALUES ('Denmark'),
    SUBPARTITION ventas_Finland VALUES ('Finland'),
    SUBPARTITION ventas_France VALUES ('France'),
    SUBPARTITION ventas_Germany VALUES ('Germany'),
    SUBPARTITION ventas_Hungary VALUES ('Hungary'),
    SUBPARTITION ventas_India VALUES ('India'),
    SUBPARTITION ventas_Ireland VALUES ('Ireland'),
    SUBPARTITION ventas_Italy VALUES ('Italy'),
    SUBPARTITION ventas_Netherlands VALUES ('Netherlands'),
    SUBPARTITION ventas_Norway VALUES ('Norway'),
    SUBPARTITION ventas_Poland VALUES ('Poland'),
    SUBPARTITION ventas_Portugal VALUES ('Portugal'),
    SUBPARTITION ventas_Spain VALUES ('Spain'),
    SUBPARTITION ventas_Sweden VALUES ('Sweden'),
    SUBPARTITION ventas_United_Kingdom VALUES ('United Kingdom'),
    SUBPARTITION ventas_USA VALUES ('USA')
)
(
PARTITION P_2009 VALUES LESS THAN (TO_DATE('01-01-2010', 'DD-MM-YYYY')),
PARTITION P_2010 VALUES LESS THAN (TO_DATE('01-01-2011', 'DD-MM-YYYY')),
PARTITION P_2011 VALUES LESS THAN (TO_DATE('01-01-2012', 'DD-MM-YYYY')),
PARTITION P_2012 VALUES LESS THAN (TO_DATE('01-01-2013', 'DD-MM-YYYY')),
PARTITION P_2013 VALUES LESS THAN (TO_DATE('01-01-2014', 'DD-MM-YYYY'))
);
--Pasamos los datos a la tabla particionada
INSERT INTO INVOICE_PARTICIONADA (
    INVOICEID,
    CUSTOMERID,
    INVOICEDATE,
    BILLINGADDRESS,
    BILLINGCITY,
    BILLINGSTATE_,
    BILLINGCOUNTRY,
    BILLINGPOSTALCODE,
    TOTAL
)
SELECT
    INVOICEID,
    CUSTOMERID,
    INVOICEDATE,
    BILLINGADDRESS,
    BILLINGCITY,
    BILLINGSTATE_,
    BILLINGCOUNTRY,
    BILLINGPOSTALCODE,
    TOTAL
FROM
    INVOICE;

-- Plan de ejecución para la tabla original
EXPLAIN PLAN FOR
SELECT *  FROM INVOICE WHERE INVOICEDATE BETWEEN TO_DATE('01-1-2011', 'DD-MM-YYYY') AND TO_DATE('31-12-2011', 'DD-MM-YYYY');
--Ver el plan de ejecucion
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
------------------------------------------------------------------------------------
-- Plan de ejecución para la tabla particionada
EXPLAIN PLAN FOR
SELECT *
FROM INVOICE_PARTICIONADA PARTITION (P_2011)
WHERE InvoiceDate BETWEEN TO_DATE('01-01-2011', 'DD-MM-YYYY') AND TO_DATE('31-12-2011', 'DD-MM-YYYY');
-- Ver el plan de ejecución
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

------------------------------------------------------------------------------


/*Particion para PLAYLISTTRACK CON  HASH*/
CREATE TABLE PLAYLISTTRACK_PARTICIONADA(
PLAYLISTID NUMBER,
TRACKID NUMBER
)
PARTITION BY HASH (TRACKID)
PARTITIONS 4;
--Pasamos los datos
INSERT INTO PLAYLISTTRACK_PARTICIONADA(
    PLAYLISTID ,
    TRACKID 
)
SELECT
    PLAYLISTID ,TRACKID 
FROM
    PLAYLISTTRACK;
--Tabla original
EXPLAIN PLAN FOR
SELECT *
FROM PLAYLISTTRACK
WHERE TRACKID = 1776;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);


--Tabla particionada
EXPLAIN PLAN FOR
SELECT *
FROM PLAYLISTTRACK_PARTICIONADA
WHERE TRACKID = 1776;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);