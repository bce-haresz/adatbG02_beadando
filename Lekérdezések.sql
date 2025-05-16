--1. Minden időpont listázása ügyfél-, fodrász- és szolgáltatásnévvel együtt

SELECT 
    Idopont.datum AS Dátum,
    Idopont.idopont AS Időpont,
    Ugyfel.nev AS Ügyfél,
    Fodrasz.nev AS Fodrász,
    Szolgaltatas.nev AS Szolgáltatás
FROM Idopont
JOIN Ugyfel ON Idopont.ugyfel_id = Ugyfel.ugyfel_id
JOIN Fodrasz ON Idopont.fodrasz_id = Fodrasz.fodrasz_id
JOIN Szolgaltatas ON Idopont.szolgaltatas_id = Szolgaltatas.szolgaltatas_id;

--2. Összesített bevétel hónaponként

SELECT 
    FORMAT(CAST(CAST(datum AS VARCHAR(50)) AS DATETIME), 'yyyy-MM') AS honap,
    SUM(osszeg) AS osszes_bevetel
FROM Fizetes
GROUP BY FORMAT(CAST(CAST(datum AS VARCHAR(50)) AS DATETIME), 'yyyy-MM')
ORDER BY honap;

--3. Legnépszerűbb szolgáltatások (időpontok száma szerint)

SELECT 
    Sz.nev,
    COUNT(*) AS alkalmak_szama
FROM Idopont I
JOIN Szolgaltatas Sz ON I.szolgaltatas_id = Sz.szolgaltatas_id
GROUP BY Sz.nev
ORDER BY alkalmak_szama DESC;

--4. Szolgáltatások átlagos ára

SELECT 
    AVG(ar) AS atlag_ar
FROM Szolgaltatas;

--5. Fodrászok időpobntjainak száma csökkenő sorrendben

SELECT 
    Fodrasz.nev AS fodrasz_nev,
    COUNT(Idopont.idopont_id) AS idopontok_szama
FROM Fodrasz
LEFT JOIN Idopont ON Fodrasz.fodrasz_id = Idopont.fodrasz_id
GROUP BY Fodrasz.nev
ORDER BY idopontok_szama DESC;

--6.Melyik ügyféltől származik a legtöbb bevétel, holtverseny mutatása

WITH BevetelPerUgyfel AS (
    SELECT 
        Ugyfel.ugyfel_id,
        Ugyfel.nev,
        SUM(Fizetes.osszeg) AS osszes_bevetel
    FROM Ugyfel
    JOIN Idopont ON Ugyfel.ugyfel_id = Idopont.ugyfel_id
    JOIN Fizetes ON Idopont.idopont_id = Fizetes.idopont_id
    GROUP BY Ugyfel.ugyfel_id, Ugyfel.nev
)
SELECT *
FROM BevetelPerUgyfel
WHERE osszes_bevetel = (SELECT MAX(osszes_bevetel) FROM BevetelPerUgyfel);
