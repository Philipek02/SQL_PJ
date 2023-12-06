

CREATE OR REPLACE PROCEDURE zamowienie
AS
        CURSOR cur1 is
        SELECT STAN FROM TOWAR WHERE NAZWA = 'krasnal ogrodowy' for update;
        REC TOWAR.STAN%TYPE;
    begin
    OPEN cur1;
    LOOP
        FETCH cur1 INTO REC;
             if cur1%NOTFOUND then
                 raise_application_error(-20500, 'nie znaleziono rekordu');
             end if;
            if REC<10 then
                UPDATE TOWAR SET STAN = REC +100 WHERE CURRENT OF cur1;
                DBMS_OUTPUT.ENABLE();
                DBMS_OUTPUT.PUT_LINE('dostarczono nowy towar');
            else
            DBMS_OUTPUT.PUT_LINE('w magazynie jest nie mniej niz 10 krasnali');
            end if;
    end loop;
    CLOSE cur1;
    end;



CREATE OR REPLACE TRIGGER trig1
AFTER UPDATE OR INSERT
    ON TOWAR
    FOR EACH ROW
    BEGIN
        IF UPDATING THEN
            IF :OLD.NAZWA != :NEW.NAZWA THEN
                RAISE_APPLICATION_ERROR(-20500, 'NIE MOZNA ZMIENIC NAZWY TOWARU');
            end if;
            IF :NEW.STAN < 0 THEN
                RAISE_APPLICATION_ERROR(-20500, 'STAN TOWARU NIE MOZE BC MNIEJSZY NIZ 0');
            end if;
            IF :NEW.CENA < 0.9 * :OLD.CENA THEN
                RAISE_APPLICATION_ERROR(-20500, 'NIE MOZNA ZMNIEJSZYC CENY O WIECEJ NIZ 10%');
            end if;
        end if;
        IF INSERTING THEN
            IF :NEW.STAN < 0 THEN
                RAISE_APPLICATION_ERROR(-20500, 'STAN TOWARU NIE MOZE BC MNIEJSZY NIZ 0');
            end if;
        end if;
    end;
