

/*******************************************************************/
/*PROCEDURES PARA ALBUM*/
/*******************************************************************/

--SP para consultar albums
CREATE OR REPLACE PROCEDURE SP_Consultar_Album
AS
    CURSOR consultar_album IS
        SELECT albumid, title, artistid
        FROM album;
BEGIN
   FOR alb IN consultar_album LOOP
         DBMS_OUTPUT.PUT_LINE('�lbum ID: ' || alb.albumid || ', Titulo: ' || alb.title || ', Artista ID: ' || alb.artistid);
   END LOOP;
END;
/

--SP para insertar un nuevo album
CREATE OR REPLACE PROCEDURE SP_Insertar_Album
(
pAlbumId album.albumid%type,
pTitle album.title%type,
pArtistid album.artistid%type
)
AS
BEGIN

    INSERT INTO ALBUM VALUES (pAlbumid, pTitle, pArtistid);
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('El �lbum se ha creado correctamente');
    
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Error, �lbum existente');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al crear el �lbum');
END;
/

--SP para actualizar album
CREATE OR REPLACE PROCEDURE SP_Actualizar_Album
(
pAlbumId album.albumid%type,
pTitle album.title%type,
pArtistId album.artistid%type
)
AS
BEGIN
    UPDATE ALBUM
    SET
        title = pTitle,
        artistid = pArtistId
    WHERE 
        albumid = pAlbumId; 
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('El �lbum se ha actualizado correctamente');
    
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al actualizar el �lbum');
    
END;
/

--SP para eliminar album
CREATE OR REPLACE PROCEDURE SP_Eliminar_Album
(
pAlbumId album.albumid%type
)
AS
BEGIN

    DELETE FROM album WHERE albumid = pAlbumId;
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('El �lbum se ha eliminado correctamente');
    
     EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al eliminar el �lbum');
    
END;
/





/*******************************************************************/
/*PROCEDURES PARA ARTISTA*/
/*******************************************************************/



--SP para consultar artistas
CREATE OR REPLACE PROCEDURE SP_Consultar_Artista
AS
    CURSOR consultar_artista IS
        SELECT artistid, name_
        FROM artist;
BEGIN
   FOR art IN consultar_artista LOOP
         DBMS_OUTPUT.PUT_LINE('Artista ID: ' || art.artistid || ', Nombre: ' || art.name_ );
   END LOOP;
END;
/

--SP para insertar un nuevo artista
CREATE OR REPLACE PROCEDURE SP_Insertar_Artista
(
pArtistId artist.artistid%type,
pName_ artist.name_%type
)
AS
BEGIN

    INSERT INTO ARTIST VALUES (pArtistId, pName_);
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('El artista se ha insertado correctamente');
    
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Error, artista existente');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al insertar el artista');
END;
/

--SP para actualizar artista
CREATE OR REPLACE PROCEDURE SP_Actualizar_Artista
(
pArtistId artist.artistid%type,
pName_ artist.name_%type
)
AS
BEGIN
    UPDATE artist
    SET
        name_ = pName_
    WHERE 
        artistid = pArtistId; 
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('El artista se ha actualizado correctamente');
    
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al actualizar el artista');
    
END;
/

--SP para eliminar album
CREATE OR REPLACE PROCEDURE SP_Eliminar_Artista
(
pArtistId artist.artistid%type
)
AS
BEGIN

    DELETE FROM artist WHERE artistid = pArtistId;
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('El artista se ha eliminado correctamente');
    
     EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al eliminar el artista');
    
END;
/




/*******************************************************************/
/*PROCEDURES PARA G�NERO*/
/*******************************************************************/


--SP para consultar g�neros
CREATE OR REPLACE PROCEDURE SP_Consultar_Genero
AS
    CURSOR consultar_genero IS
        SELECT genreid, name_
        FROM genre;
BEGIN
   FOR gen IN consultar_genero LOOP
         DBMS_OUTPUT.PUT_LINE('G�nero ID: ' || gen.genreid || ', Nombre: ' || gen.name_ );
   END LOOP;
END;
/

--SP para insertar un nuevo g�nero
CREATE OR REPLACE PROCEDURE SP_Insertar_Genero
(
pGenreId genre.genreid%type,
pName_ genre.name_%type
)
AS
BEGIN

    INSERT INTO ARTIST VALUES (pGenreId, pName_);
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('El g�nero se ha insertado correctamente');
    
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Error, g�nero existente');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al insertar el g�nero');
END;
/

--SP para actualizar g�nero
CREATE OR REPLACE PROCEDURE SP_Actualizar_Genero
(
pGenreId genre.genreid%type,
pName_ genre.name_%type
)
AS
BEGIN
    UPDATE genre
    SET
        name_ = pName_
    WHERE 
        genreid = pGenreId; 
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('El g�nero se ha actualizado correctamente');
    
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al actualizar el g�nero');
    
END;
/

--SP para eliminar g�nero
CREATE OR REPLACE PROCEDURE SP_Eliminar_Genero
(
pGenreId genre.genreid%type
)
AS
BEGIN

    DELETE FROM genre WHERE genreid = pGenreId;
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('El g�nero se ha eliminado correctamente');
    
     EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al eliminar el g�nero');
            
END;
/



/*******************************************************************/
/*PROCEDURES PARA INVOICELINE*/
/*******************************************************************/


--SP para consultar invoiceline
CREATE OR REPLACE PROCEDURE SP_Consultar_Invoiceline
AS
    CURSOR consultar_invoiceline IS
        SELECT invoicelineid, invoiceid, trackid, unitprice, quantity
        FROM invoiceline;
BEGIN
   FOR ivln IN consultar_invoiceline LOOP
         DBMS_OUTPUT.PUT_LINE('Invoiceline ID: ' || ivln.invoicelineid || ', Invoice ID: ' || ivln.invoiceid || ', Track ID: ' || ivln.trackid || ', Precio �nico: ' || ivln.unitprice || ', Cantidad: ' || ivln.quantity);
   END LOOP;
END;
/

--SP para insertar un nuevo invoiceline
CREATE OR REPLACE PROCEDURE SP_Insertar_Invoiceline
(
pInvoicelineid invoiceline.invoicelineid%type,
pInvoiceid invoiceline.invoiceid%type,
pTrackid invoiceline.trackid%type,
pUnitprice invoiceline.unitprice%type,
pQuantity invoiceline.quantity%type
)
AS
BEGIN

    INSERT INTO invoiceline VALUES 
    (
    pInvoicelineid,
    pInvoiceid,
    pTrackid,
    pUnitprice,
    pQuantity
    );
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('El invoiceline se ha insertado correctamente');
    
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Error, invoiceline existente');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al insertar invoiceline');
END;
/

--SP para actualizar invoiceline
CREATE OR REPLACE PROCEDURE SP_Actualizar_Invoiceline
(
pInvoicelineid invoiceline.invoicelineid%type,
pInvoiceid invoiceline.invoiceid%type,
pTrackid invoiceline.trackid%type,
pUnitprice invoiceline.unitprice%type,
pQuantity invoiceline.quantity%type
)
AS
BEGIN
    UPDATE invoiceline
    SET
        Invoiceid = pInvoiceid,
        Trackid = pTrackid,
        Unitprice = pUnitprice,
        Quantity = pQuantity
    WHERE 
        invoicelineid = pInvoicelineid; 
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Invoiceline se ha actualizado correctamente');
    
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al actualizar invoiceline');
    
END;
/

--SP para eliminar invoiceline
CREATE OR REPLACE PROCEDURE SP_Eliminar_Invoiceline
(
pInvoicelineid invoiceline.invoicelineid%type
)
AS
BEGIN

    DELETE FROM invoiceline WHERE invoicelineid = pInvoicelineid;
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('El invoiceline se ha eliminado correctamente');
    
     EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al eliminar el invoiceline');
            
END;
/





/*******************************************************************/
/*PROCEDURES PARA MEDIATYPE*/
/*******************************************************************/


--SP para consultar mediatype
CREATE OR REPLACE PROCEDURE SP_Consultar_MediaType
AS
    CURSOR consultar_mediatype IS
        SELECT mediatypeid, name_
        FROM mediatype;
BEGIN
   FOR mety IN consultar_mediatype LOOP
         DBMS_OUTPUT.PUT_LINE('Mediatype ID: ' || mety.mediatypeid || ', Nombre: ' || mety.name_ );
   END LOOP;
END;
/

--SP para insertar un nuevo g�nero
CREATE OR REPLACE PROCEDURE SP_Insertar_Mediatype
(
pMediatypeId mediatype.mediatypeid%type,
pName_ mediatype.name_%type
)
AS
BEGIN

    INSERT INTO mediatype VALUES (pMediatypeId, pName_);
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Mediatype se ha insertado correctamente');
    
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Error, mediatype existente');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al insertar mediatype');
END;
/

--SP para actualizar mediatype
CREATE OR REPLACE PROCEDURE SP_Actualizar_Mediatype
(
pMediatypeId mediatype.mediatypeid%type,
pName_ mediatype.name_%type
)
AS
BEGIN
    UPDATE mediatype
    SET
        name_ = pName_
    WHERE 
        mediatypeid = pMediatypeId; 
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('El mediatype se ha actualizado correctamente');
    
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al actualizar mediatype');
    
END;
/

--SP para eliminar mediatype
CREATE OR REPLACE PROCEDURE SP_Eliminar_Mediatype
(
pMediatypeId mediatype.mediatypeid%type
)
AS
BEGIN

    DELETE FROM mediatype WHERE mediatypeid = pMediatypeId;
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('El mediatype se ha eliminado correctamente');
    
     EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al eliminar el mediatype');
            
END;
/




/*******************************************************************/
/*PROCEDURES PARA PLAYLIST*/
/*******************************************************************/


--SP para consultar una playlist
CREATE OR REPLACE PROCEDURE SP_Consultar_Playlist
AS
    CURSOR consultar_playlist IS
        SELECT playlistid, name_
        FROM playlist;
BEGIN
   FOR plts IN consultar_playlist LOOP
         DBMS_OUTPUT.PUT_LINE('Playlist ID: ' || plts.playlistid || ', Nombre: ' || plts.name_ );
   END LOOP;
END;
/

--SP para insertar una nueva playlist
CREATE OR REPLACE PROCEDURE SP_Insertar_Playlist
(
pPlaylistId playlist.playlistid%type,
pName_ playlist.name_%type
)
AS
BEGIN

    INSERT INTO playlist VALUES (pPlaylistId, pName_);
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('La playlist se ha insertado correctamente');
    
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Error, playlist existente');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al insertar una playlist');
END;
/

--SP para actualizar una playlist
CREATE OR REPLACE PROCEDURE SP_Actualizar_Playlist
(
pPlaylistId playlist.playlistid%type,
pName_ playlist.name_%type
)
AS
BEGIN
    UPDATE playlist
    SET
        name_ = pName_
    WHERE 
        playlistid = pPlaylistId; 
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('La playlist se ha actualizado correctamente');
    
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al actualizar una playlist');
    
END;
/

--SP para eliminar una playlist
CREATE OR REPLACE PROCEDURE SP_Eliminar_Playlist
(
pPlaylistId playlist.playlistid%type
)
AS
BEGIN

    DELETE FROM playlist WHERE playlistid = pPlaylistId;
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('La playlist se ha eliminado correctamente');
    
     EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al eliminar la playlist');
            
END;
/



/*******************************************************************/
/*PROCEDURES PARA PLAYLISTTRACK*/
/*******************************************************************/


--SP para consultar un playlisttrack
CREATE OR REPLACE PROCEDURE SP_Consultar_PlaylistTrack
AS
    CURSOR consultar_playlisttrack IS
        SELECT playlistid, trackid
        FROM playlisttrack;
BEGIN
   FOR plts IN consultar_playlisttrack LOOP
         DBMS_OUTPUT.PUT_LINE('Playlist ID: ' || plts.playlistid || ', Nombre: ' || plts.trackid );
   END LOOP;
END;
/

--SP para insertar un nuevo playlisttrack
CREATE OR REPLACE PROCEDURE SP_Insertar_PlaylistTrack
(
pPlaylistId playlisttrack.playlistid%type,
pTrackId playlisttrack.trackid%type
)
AS
BEGIN

    INSERT INTO playlisttrack VALUES (pPlaylistId, pTrackId);
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('El playlisttrack se ha insertado correctamente');
    
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Error, playlisttrack existente');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al insertar el playlisttrack');
END;
/

--SP para actualizar una playlisttrack
CREATE OR REPLACE PROCEDURE SP_Actualizar_PlaylistTrack
(
pPlaylistId playlisttrack.playlistid%type,
pTrackId playlisttrack.trackid%type
)
AS
BEGIN
    UPDATE playlisttrack
    SET
        playlistid = pPlaylistId
        
    WHERE 
        trackid = pTrackId; 
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('La playlisttrack se ha actualizado correctamente');
    
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al actualizar una playlisttrack');
    
END;
/

--SP para eliminar una playlisttrack
CREATE OR REPLACE PROCEDURE SP_Eliminar_PlaylistTrack
(
pTrackId playlisttrack.trackid%type
)
AS
BEGIN

    DELETE FROM playlisttrack WHERE playlistid = pTrackId;
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('El playlisttrack se ha eliminado correctamente');
    
     EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al eliminar el playlisttrack');
            
END;
/


/*******************************************************************/
/*PROCEDURES PARA EMPLOYEE*/
/*******************************************************************/


--SP para consultar empleados
CREATE OR REPLACE PROCEDURE SP_Consultar_Employee
AS
    CURSOR consultar_employee IS
        SELECT 
            employeeid, 
            lastname, 
            firstname, 
            title, 
            reportsto, 
            birthdate,
            hiredate, 
            address, 
            city, 
            state_, 
            country, 
            postalcode, 
            phone, 
            fax, 
            email
        FROM employee;
BEGIN
   FOR emp IN consultar_employee LOOP
         DBMS_OUTPUT.PUT_LINE(
                             'Empleado ID: ' || emp.employeeid || 
                             ', Apellido: ' || emp.lastname ||
                             ', Nombre: ' || emp.firstname ||
                             ', Titulo: ' || emp.title ||
                             ', Fecha de nacimiento: ' || emp.birthdate ||
                             ', Fecha de contrataci�n: ' || emp.hiredate ||
                             ', Direcci�n: ' || emp.address ||
                             ', Ciudad: ' || emp.city ||
                             ', Estado: ' || emp.state_ ||
                             ', Pa�s: ' || emp.country ||
                             ', C�digo postal: ' || emp.postalcode ||
                             ', Tel�fono: ' || emp.phone ||
                             ', Fax: ' || emp.fax ||
                             ', Correo: ' || emp.email
                             );
   END LOOP;
END;
/

--SP para insertar un nuevo empleado
CREATE OR REPLACE PROCEDURE SP_Insertar_Employee
(
pEmployeeid employee.employeeid%type,
pLastname employee.lastname%type,
pFirstname employee.firstname%type,
pTitle employee.title%type,
pReportsto employee.reportsto%type,
pBirthdate employee.birthdate%type,
pHiredate employee.hiredate%type,
pAddress employee.address%type,
pCity employee.city%type,
pState_ employee.state_%type,
pCountry employee.country%type,
pPostalcode employee.postalcode%type,
pPhone employee.phone%type,
pFax employee.fax%type,
pEmail employee.email%type
)
AS
BEGIN

    INSERT INTO employee 
    VALUES  (
            pEmployeeid, 
            pLastname, 
            pFirstname, 
            pTitle, 
            pReportsto, 
            pBirthdate, 
            pHiredate, 
            pAddress, 
            pCity, 
            pState_, 
            pCountry, 
            pPostalcode, 
            pPhone, 
            pFax, 
            pEmail  
            );
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('El empleado se ha insertado correctamente');
    
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Error, empleado existente');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al insertar el empleado');
END;
/

--SP para actualizar un empleado
CREATE OR REPLACE PROCEDURE SP_Actualizar_Employee
(
pEmployeeid employee.employeeid%type,
pLastname employee.lastname%type,
pFirstname employee.firstname%type,
pTitle employee.title%type,
pReportsto employee.reportsto%type,
pBirthdate employee.birthdate%type,
pHiredate employee.hiredate%type,
pAddress employee.address%type,
pCity employee.city%type,
pState_ employee.state_%type,
pCountry employee.country%type,
pPostalcode employee.postalcode%type,
pPhone employee.phone%type,
pFax employee.fax%type,
pEmail employee.email%type
)
AS
BEGIN
    UPDATE employee
    SET 
        lastname = pLastname,
        firstname = pFirstname,
        title = pTitle,
        reportsto = pReportsto,
        birthdate = pBirthdate,
        hiredate = pHiredate,
        address = pAddress,
        city = pCity,
        state_ = pState_,
        country = pCountry,
        postalcode = pPostalcode,
        phone = pPhone,
        fax = pFax,
        email = pEmail
    WHERE 
        employeeid = pEmployeeid; 
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('El empleado se ha actualizado correctamente');
    
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al actualizar un empleado');
    
END;
/

--SP para eliminar un empleado
CREATE OR REPLACE PROCEDURE SP_Eliminar_Employee
(
pEmployeeid employee.employeeid%type
)
AS
BEGIN

    DELETE FROM employee WHERE employeeid = pEmployeeid;
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('El empelado se ha eliminado correctamente');
    
     EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al eliminar el empleado');
            
END;
/






/*******************************************************************/
/*PROCEDURES PARA INVOICE*/
/*******************************************************************/


--SP para consultar facturas
CREATE OR REPLACE PROCEDURE SP_Consultar_Invoice
AS
    CURSOR consultar_invoice IS
        SELECT 
            invoiceid,
            customerid,
            invoicedate,
            billingaddress,
            billingcity,
            billingstate_,
            billingcountry,
            billingpostalcode,
            total
        FROM invoice;
BEGIN
   FOR inv IN consultar_invoice LOOP
         DBMS_OUTPUT.PUT_LINE(
                             'Factura ID: ' || inv.invoiceid || 
                             ', Cliente ID: ' || inv.customerid ||
                             ', Fecha de Factura: ' || inv.invoicedate ||
                             ', Direcci�n de Facturaci�n: ' || inv.billingaddress ||
                             ', Ciudad de Facturaci�n: ' || inv.billingcity ||
                             ', Estado de Facturaci�n: ' || inv.billingstate_ ||
                             ', Pa�s de Facturaci�n: ' || inv.billingcountry ||
                             ', C�digo Postal de Facturaci�n: ' || inv.billingpostalcode ||
                             ', Total: ' || inv.total
                             );
   END LOOP;
END;
/

--SP para insertar un nueva factura
CREATE OR REPLACE PROCEDURE SP_Insertar_Invoice
(
pInvoiceid invoice.invoiceid%type,
pCustomerid invoice.customerid%type,
pInvoicedate invoice.invoicedate%type,
pBillingaddress invoice.billingaddress%type,
pBillingcity invoice.billingcity%type,
pBillingstate_ invoice.billingstate_%type,
pBillingcountry invoice.billingcountry%type,
pBillingpostalcode invoice.billingpostalcode%type,
pTotal invoice.total%type
)
AS
BEGIN
    INSERT INTO invoice
    VALUES  (
            pInvoiceid, 
            pCustomerid, 
            pInvoicedate, 
            pBillingaddress, 
            pBillingcity, 
            pBillingstate_, 
            pBillingcountry, 
            pBillingpostalcode, 
            pTotal
            );
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('La factura se ha insertado correctamente');
    
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Error, factura existente');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al insertar la factura');
END;
/


--SP para actualizar una factura
CREATE OR REPLACE PROCEDURE SP_Actualizar_Invoice
(
pInvoiceid invoice.invoiceid%type,
pCustomerid invoice.customerid%type,
pInvoicedate invoice.invoicedate%type,
pBillingaddress invoice.billingaddress%type,
pBillingcity invoice.billingcity%type,
pBillingstate_ invoice.billingstate_%type,
pBillingcountry invoice.billingcountry%type,
pBillingpostalcode invoice.billingpostalcode%type,
pTotal invoice.total%type
)
AS
BEGIN
    UPDATE invoice
    SET 
        customerid = pCustomerid,
        invoicedate = pInvoicedate,
        billingaddress = pBillingaddress,
        billingcity = pBillingcity,
        billingstate_ = pBillingstate_,
        billingcountry = pBillingcountry,
        billingpostalcode = pBillingpostalcode,
        total = pTotal
    WHERE 
        invoiceid = pInvoiceid;
        
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('La factura se ha actualizado correctamente');
    
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al actualizar la factura');
    
END;
/


--SP para eliminar una factura
CREATE OR REPLACE PROCEDURE SP_Eliminar_Invoice
(
pInvoiceid invoice.invoiceid%type
)
AS
BEGIN

    DELETE FROM invoice WHERE invoiceid = pInvoiceid;
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('La factura se ha eliminado correctamente');
    
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al eliminar la factura');
            
END;
/



/*******************************************************************/
/*PROCEDURES PARA TRACK*/
/*******************************************************************/


--SP para consultar pistas
CREATE OR REPLACE PROCEDURE SP_Consultar_Track
AS
    CURSOR consultar_track IS
        SELECT 
            trackid,
            name_,
            albumid,
            mediatypeid,
            genreid,
            composer,
            milliseconds,
            bytes,
            unitprice
        FROM track;
BEGIN
   FOR trk IN consultar_track LOOP
         DBMS_OUTPUT.PUT_LINE(
                             'Track ID: ' || trk.trackid || 
                             ', Nombre: ' || trk.name_ ||
                             ', Album ID: ' || trk.albumid ||
                             ', Media Type ID: ' || trk.mediatypeid ||
                             ', Genre ID: ' || trk.genreid ||
                             ', Compositor: ' || trk.composer ||
                             ', Milisegundos: ' || trk.milliseconds ||
                             ', Bytes: ' || trk.bytes ||
                             ', Precio Unitario: ' || trk.unitprice
                             );
   END LOOP;
END;
/


--SP para insertar una nueva pista
CREATE OR REPLACE PROCEDURE SP_Insertar_Track
(
pTrackid track.trackid%type,
pName_ track.name_%type,
pAlbumid track.albumid%type,
pMediatypeid track.mediatypeid%type,
pGenreid track.genreid%type,
pComposer track.composer%type,
pMilliseconds track.milliseconds%type,
pBytes track.bytes%type,
pUnitprice track.unitprice%type
)
AS
BEGIN
    INSERT INTO track
    VALUES  (
            pTrackid, 
            pName_, 
            pAlbumid, 
            pMediatypeid, 
            pGenreid, 
            pComposer, 
            pMilliseconds, 
            pBytes, 
            pUnitprice
            );
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('La pista se ha insertado correctamente');
    
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Error, pista existente');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al insertar una pista');
END;
/



--SP para actualizar una psita
CREATE OR REPLACE PROCEDURE SP_Actualizar_Track
(
pTrackid track.trackid%type,
pName_ track.name_%type,
pAlbumid track.albumid%type,
pMediatypeid track.mediatypeid%type,
pGenreid track.genreid%type,
pComposer track.composer%type,
pMilliseconds track.milliseconds%type,
pBytes track.bytes%type,
pUnitprice track.unitprice%type
)
AS
BEGIN
    UPDATE track
    SET 
        name_ = pName_,
        albumid = pAlbumid,
        mediatypeid = pMediatypeid,
        genreid = pGenreid,
        composer = pComposer,
        milliseconds = pMilliseconds,
        bytes = pBytes,
        unitprice = pUnitprice
    WHERE 
        trackid = pTrackid;
        
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('La pista se ha actualizado correctamente');
    
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al actualizar una pista');
    
END;
/



--SP para eliminar una pista
CREATE OR REPLACE PROCEDURE SP_Eliminar_Track
(
pTrackid track.trackid%type
)
AS
BEGIN

    DELETE FROM track WHERE trackid = pTrackid;
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('La pista se ha eliminado correctamente');
    
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al eliminar una pista');
            
END;
/

/*******************************************************************/
/*PROCEDURES PARA CUSTOMER*/
/*******************************************************************/


--SP para consultar clientes
CREATE OR REPLACE PROCEDURE SP_Consultar_Customer
AS
    CURSOR consultar_customer IS
        SELECT 
            customerid,
            firstname,
            lastname,
            company,
            address,
            city,
            state_,
            country,
            postalcode,
            phone,
            fax,
            email,
            supportrepid
        FROM customer;
BEGIN
   FOR cust IN consultar_customer LOOP
         DBMS_OUTPUT.PUT_LINE(
                             'Cliente ID: ' || cust.customerid || 
                             ', Apellido: ' || cust.lastname ||
                             ', Nombre: ' || cust.firstname ||
                             ', Compa��a: ' || cust.company ||
                             ', Direcci�n: ' || cust.address ||
                             ', Ciudad: ' || cust.city ||
                             ', Estado: ' || cust.state_ ||
                             ', Pa�s: ' || cust.country ||
                             ', C�digo postal: ' || cust.postalcode ||
                             ', Tel�fono: ' || cust.phone ||
                             ', Fax: ' || cust.fax ||
                             ', Correo: ' || cust.email ||
                             ', Supportrepid: ' || cust.supportrepid
                             );
   END LOOP;
END;
/

--SP para insertar un nuevo cliente
CREATE OR REPLACE PROCEDURE SP_Insertar_Customer
(
pCustomerid customer.customerid%type,
pLastname customer.lastname%type,
pFirstname customer.firstname%type,
pCompany customer.company%type,
pAddress customer.address%type,
pCity customer.city%type,
pState_ customer.state_%type,
pCountry customer.country%type,
pPostalcode customer.postalcode%type,
pPhone customer.phone%type,
pFax customer.fax%type,
pEmail customer.email%type,
pSupportrepid customer.supportrepid%type
)
AS
BEGIN

    INSERT INTO customer
    VALUES  (
            pCustomerid, 
            pLastname, 
            pFirstname, 
            pCompany, 
            pAddress, 
            pCity, 
            pState_, 
            pCountry, 
            pPostalcode, 
            pPhone, 
            pFax, 
            pEmail, 
            pSupportrepid
            );
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('El cliente se ha insertado correctamente');
    
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Error, cliente existente');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al insertar el cliente');
END;
/

--SP para actualizar un cliente
CREATE OR REPLACE PROCEDURE SP_Actualizar_Customer
(
pCustomerid customer.customerid%type,
pLastname customer.lastname%type,
pFirstname customer.firstname%type,
pCompany customer.company%type,
pAddress customer.address%type,
pCity customer.city%type,
pState_ customer.state_%type,
pCountry customer.country%type,
pPostalcode customer.postalcode%type,
pPhone customer.phone%type,
pFax customer.fax%type,
pEmail customer.email%type,
pSupportrepid customer.supportrepid%type
)
AS
BEGIN
    UPDATE customer
    SET 
        lastname = pLastname,
        firstname = pFirstname,
        company = pCompany,
        address = pAddress,
        city = pCity,
        state_ = pState_,
        country = pCountry,
        postalcode = pPostalcode,
        phone = pPhone,
        fax = pFax,
        email = pEmail,
        supportrepid = pSupportrepid
    WHERE 
        customerid = pCustomerid;
        
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('El cliente se ha actualizado correctamente');
    
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al actualizar un cliente');
    
END;
/

--SP para eliminar un cliente
CREATE OR REPLACE PROCEDURE SP_Eliminar_Customer
(
pCustomerid customer.customerid%type
)
AS
BEGIN

    DELETE FROM customer WHERE customerid = pCustomerid;
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('El cliente se ha eliminado correctamente');
    
     EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error al eliminar el cliente');
            
END;
/


