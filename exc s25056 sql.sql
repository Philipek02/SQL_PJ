--Wypisaæ imiona i nazwiska studentów którzy otrzymali  z  przedmiotu ALG ocenê  lepsz¹ ni¿ œrednia z wszystkich ocen z tego przedmiotu


SELECT s.imie, s.nazwisko
FROM a1_student s
WHERE s.idstudent IN(
    SELECT DISTINCT o.idstudent
    FROM a1_ocena o
    WHERE o.ocena > (SELECT AVG(o2.ocena)
                    FROM a1_ocena o2
                    WHERE o2.idprzedmiot = (SELECT p.idprzedmiot
                                            FROM a1_przedmiot p
                                            WHERE p.symbol LIKE 'ALG')
                    ));
                    
                    
--Odszukaæ Katedrê, dla której  jest najni¿sza œrednia ( podaæ  jej  wartoœæ)

SELECT p.katedra, AVG(o.ocena)
FROM a1_przedmiot p
INNER JOIN a1_ocena o
ON o.idprzedmiot = p.idprzedmiot
GROUP BY p.katedra
HAVING AVG(o.ocena) =(
    SELECT MIN(AVG(o.ocena))
    FROM a1_ocena o
    INNER JOIN a1_przedmiot p
    ON p.idprzedmiot = o.idprzedmiot
    GROUP BY p.katedra);


--Dla Katedry Bazy danych podaæ nazwisko osoby, która  ma najwy¿sz¹ œredni¹ z przedmiotów nale¿¹cych do tej katedry




        SELECT s.nazwisko
        FROM a1_ocena o
        INNER JOIN a1_student s
        ON s.idstudent = o.idstudent
        INNER JOIN a1_przedmiot p
        ON p.idprzedmiot = o.idprzedmiot
        WHERE p.katedra LIKE 'Bazy danych'
        GROUP BY o.idstudent, s.nazwisko
        order by AVG(o.ocena);
        
        
        --Wypisaæ imiona i nazwiska studentów, którzy maj¹  wiêcej ni¿ 1 a mniej ni¿  4 oceny wystawione w 2013r  Podaæ liczbê ich ocen.



SELECT s.imie, s.nazwisko, COUNT(*) 
FROM a1_student s
INNER JOIN a1_ocena o
ON o.idstudent = s.idstudent
GROUP BY s.imie, s.nazwisko
HAVING COUNT (*) IN(

        SELECT COUNT(*)
        FROM a1_ocena o
        where extract(year from(o.datawystawienia)) = 2013
        GROUP by o.idstudent
        HAVING (COUNT(*) BETWEEN 1 and 3));


--Dla ka¿dego studenta wypisaæ przedmiot z którego ma najni¿sz¹ ocenê. Podaæ jej wartoœæ

SELECT DISTINCT o.idstudent, MIN(o.ocena), p.przedmiot
FROM a1_ocena o
INNER JOIN a1_przedmiot p
ON p.idprzedmiot = o.idprzedmiot
GROUP BY o.idstudent, p.przedmiot
HAVING MIN(o.ocena) IN(
        SELECT MIN(o.ocena)
        FROM a1_ocena o
        GROUP BY o.idprzedmiot, o.idstudent)
order by o.idstudent;



--Wypisaæ numery i nazwiska studentów, którzy zdawali  ALG w tym samym dniu co Klara Koperek
SELECT s.id



