
--Funcion para obtener el empleado del mes 
CREATE OR REPLACE FUNCTION fn_top_empleado
  RETURN VARCHAR2
IS
  top_empleado VARCHAR2(100);
BEGIN
  SELECT e.FirstName || ' ' || e.LastName
  INTO top_empleado
  FROM Employee e
  INNER JOIN Customer c ON e.EmployeeId = c.SupportRepId
  INNER JOIN Invoice i ON c.CustomerId = i.CustomerId
  INNER JOIN InvoiceLine il ON i.InvoiceId = il.InvoiceId
  GROUP BY e.FirstName, e.LastName
  ORDER BY SUM(i.Total) DESC
  FETCH FIRST 1 ROWS ONLY;

  RETURN top_empleado;
END;
/
--Bloque anonimo
DECLARE
  v_top_empleado VARCHAR2(100);
BEGIN
  -- Llamada a la funci贸n que obtiene el nombre del empleado con m谩s ventas
  v_top_empleado := fn_top_empleado;

  -- Mostrar el resultado
  DBMS_OUTPUT.PUT_LINE('El empleado con m谩s ventas es: ' || v_top_empleado);
END;
/

/*---------------------------------------------------- 
---Funcion para ver la fecha de nacimiento de un empleado 
CREATE OR REPLACE FUNCTION fn_calcular_edad(p_birthdate DATE)
  RETURN NUMBER
IS
  v_age NUMBER;
BEGIN
  v_age := TRUNC(MONTHS_BETWEEN(SYSDATE, p_birthdate) / 12);
  RETURN v_age;
END;
/

--Bloque anonimo

DECLARE
  v_employee_id NUMBER := 1;  -- Suponiendo que estamos buscando al empleado con ID 1
  v_birthdate   DATE;
  v_age         NUMBER;
BEGIN
  -- Obtener la fecha de nacimiento del empleado
  SELECT BirthDate
  INTO v_birthdate
  FROM Employee
  WHERE EmployeeId = v_employee_id;

  -- Calcular la edad usando la funci贸n fn_calcular_edad
  v_age := fn_calcular_edad(v_birthdate);

  -- Mostrar la edad del empleado
  DBMS_OUTPUT.PUT_LINE('La edad del empleado con ID ' || v_employee_id || ' es: ' || v_age || ' a帽os');
END;
/

----------------------------------------------------------
---Funcion para ver la cantidad de a帽os trabajados de un empleado 
CREATE OR REPLACE FUNCTION fn_calcular_tiempo_trabajado
(
p_hiredate DATE
)
  RETURN NUMBER
IS
  v_age NUMBER;
BEGIN
  v_age := TRUNC(MONTHS_BETWEEN(SYSDATE, p_hiredate) / 12);
  RETURN v_age;
END;
/

--Bloque an髇imo
DECLARE
  v_employee_id NUMBER := 1;  -- Suponiendo que estamos buscando al empleado con ID 1
  v_hiredate   DATE;
  v_anhos       NUMBER;
BEGIN
  -- Obtener la fecha de contrataci髇 del empleado
  SELECT hiredate
  INTO v_hiredate
  FROM Employee
  WHERE EmployeeId = v_employee_id;

  -- Calcular la edad usando la funci贸n fn_calcular_tiempo_trabajado
  v_age := fn_calcular_tiempo_trabajado(v_hiredate);

  -- Mostrar la edad del empleado
  DBMS_OUTPUT.PUT_LINE('Los a駉s trabajados del empleado con ID ' || v_employee_id || ' es: ' || v_anhos || ' a駉s');
END;
/

---------------------------------------------------------------------
--Funcion para calcular los bytes a MB
CREATE OR REPLACE FUNCTION fn_convertir_bytes(p_bytes NUMBER)
  RETURN NUMBER
IS
  v_mb NUMBER;
BEGIN
  v_mb := p_bytes / (1024 * 1024);
  RETURN v_mb;
END;
/

--Bloque anonimo 
DECLARE
  v_bytes NUMBER := 10485760;  -- Ejemplo: 10 MB en bytes
  v_mb    NUMBER;
BEGIN
  -- Llamada a la funci贸n para convertir bytes a MB
  v_mb := fn_convertir_bytes(v_bytes);

  -- Mostrar el resultado de la conversi贸n
  DBMS_OUTPUT.PUT_LINE('El valor en bytes: ' || v_bytes || ' equivale a ' || v_mb || ' MB');
END;
/

---------------------------------------------------------------------
--Funcion para calcular los milesegundos a segundos

CREATE OR REPLACE FUNCTION fn_calcular_segundos (p_milliseconds NUMBER)
RETURN NUMBER
IS
BEGIN
    RETURN p_milliseconds / 1000;
END;
/

--Bloque anonimo 
DECLARE
  v_milisegundos NUMBER := 10000;  -- Ejemplo: 10000 milisegundos
  v_seg  NUMBER;
BEGIN
  -- Llamada a la funci贸n para convertir milisegundos a segundos
  v_seg := fn_calcular_segundos(v_milisegundos);

  -- Mostrar el resultado de la conversi贸n
  DBMS_OUTPUT.PUT_LINE('El valor en milisegundos: ' || v_milisegundos || ' equivale a ' || v_seg || ' segundos');
END;
/
