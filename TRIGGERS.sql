
/*
-TRIGGER QUE VALIDA UNA FECHA DE FACTURA NO SEA MENOR A LA ACTUAL

ERROR 20001: Este validación se mostrara cuando se intente insertar o actualizar una factura con una fecha menor a la actual
*/

CREATE OR REPLACE TRIGGER TR_ValidaFechaInvoice
BEFORE 
    INSERT OR UPDATE
ON invoice
FOR EACH ROW

DECLARE
vInvoiceDate invoice.invoicedate%type;

BEGIN  
        
    vInvoiceDate := :new.invoicedate;    

    IF vInvoiceDate < SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20001, 'La fecha de la factura no puede ser menor a la actual');
    END IF;  

END;

--INSERT INTO invoice VALUES (99, 102, TO_DATE('2024-01-01', 'YYYY-MM-DD'), '456 Oak St', 'Shelbyville', 'IL', 'USA', '62565', 300.00);

/*
-TRIGGER QUE VALIDA QUE UN EMPLEADO NO SEA MENOR DE EDAD

ERROR 20002: Este validación se mostrara cuando se intente insertar o actualizar un empleado y su edad sea menor a 18
*/

CREATE OR REPLACE TRIGGER TR_EdadEmployee
BEFORE 
    INSERT OR UPDATE
ON employee
FOR EACH ROW

DECLARE
vEdad number;
vBirthDate employee.birthdate%type;

BEGIN  
        
    vBirthDate := :new.birthdate; 
    
    vEdad := fn_calcular_edad(vBirthDate);

    IF vEdad < 18 THEN
        RAISE_APPLICATION_ERROR(-20002, 'El empleado deber ser mayor de edad');
    END IF;  

END;

--INSERT INTO employee VALUES (99, 'Gomez', 'Luis', 'Manager', 5, TO_DATE('2010-05-15', 'YYYY-MM-DD'), TO_DATE('2024-08-18', 'YYYY-MM-DD'), '123 Main St', 'Springfield', 'IL', 'USA', '62701', '555-1234', '555-5678', 'luis.gomez@example.com');

/*
-TRIGGER QUE VALIDA NEGATIVOS EN TRACK

ERROR 20003: Este validación se mostrara cuando se intente insertar o actualizar una pista que los milisegundos no sean negativos

ERROR 20004: Este validación se mostrara cuando se intente insertar o actualizar una pista que los bytes no sean negativos

ERROR 20005: Este validación se mostrara cuando se intente insertar o actualizar una pista que el precio único no sea negativo

*/

CREATE OR REPLACE TRIGGER TR_ValidaNegativosTrack
BEFORE 
    INSERT OR UPDATE
ON track
FOR EACH ROW

DECLARE
vNumero number;

BEGIN  
        
    vNumero := :new.MILLISECONDS; 

    IF vNumero < 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Los milisegundos no deben ser negativos');
    END IF;  
    
    
    vNumero := :new.bytes; 

    IF vNumero < 0 THEN
        RAISE_APPLICATION_ERROR(-20004, 'Los bytes no deben ser negativos');
    END IF;  
    
    vNumero := :new.unitprice; 

    IF vNumero < 0 THEN
        RAISE_APPLICATION_ERROR(-20005, 'El precio único no debe ser negativo');
    END IF;

END;


--INSERT INTO track  VALUES (99, 'Song Title', 10, 1, 5, 'Composer Name', -10000, 4500000, 0.99);
--INSERT INTO track  VALUES (99, 'Song Title', 10, 1, 5, 'Composer Name', 10000, -100000, 0.99);
--INSERT INTO track  VALUES (99, 'Song Title', 10, 1, 5, 'Composer Name', 10000, 100000, -0.99);

/*
-TRIGGER QUE VALIDA NEGATIVOS EN INVOICELINE

ERROR 20006: Este validación se mostrara cuando se intente insertar o actualizar una linea de factura que el precio único no sea negativo

ERROR 20007: Este validación se mostrara cuando se intente insertar o actualizar una linea de factura que la cantidad no sea negativa

*/

CREATE OR REPLACE TRIGGER TR_ValidaNegativosInvoiceline
BEFORE 
    INSERT OR UPDATE
ON invoiceline
FOR EACH ROW

DECLARE
vNumero number;

BEGIN  
        
    vNumero := :new.unitprice; 

    IF vNumero < 0 THEN
        RAISE_APPLICATION_ERROR(-20006, 'El precio único no debe ser negativo');
    END IF;  
    
    
    vNumero := :new.quantity; 

    IF vNumero < 0 THEN
        RAISE_APPLICATION_ERROR(-20007, 'La cantidad no debe ser negativa');
    END IF;  

END;

--INSERT INTO invoiceline VALUES (99, 101, 1, -0.99, 2);
--INSERT INTO invoiceline VALUES (99, 101, 1, 0.99, -1);





