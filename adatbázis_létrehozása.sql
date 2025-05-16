--Ügyfél tábla létrehozása és adatokkal való feltöltése:

CREATE TABLE Ugyfel (
    ugyfel_id INT PRIMARY KEY,
    nev NVARCHAR(100) NOT NULL,
    telefonszam TEXT,
    email NVARCHAR(320)
);
INSERT INTO Ugyfel (ugyfel_id, nev, telefonszam, email) VALUES
(1, 'Kiss Anna', '06201234567', 'anna.kiss@example.com'),
(2, 'Nagy Péter', '06201112233', 'peter.nagy@example.com'),
(3, 'Szabó Éva', '06203455678', 'eva.szabo@example.com');


--Fodrász tábla létrehozása és adatokkal való feltöltése:

CREATE TABLE Fodrasz (
    fodrasz_id INT PRIMARY KEY,
    nev NVARCHAR(100) NOT NULL,
    szakma NVARCHAR(100)
);
INSERT INTO Fodrasz (fodrasz_id, nev, szakma) VALUES
(1, 'Molnár Géza', 'Hajvágás'),
(2, 'Hargitai Marcell', 'Festés'),
(3, 'Bognár Dániel', 'Styling');


--Szolgáltatás tábla létrehozása és adatokkal való feltöltése:

CREATE TABLE Szolgaltatas (
    szolgaltatas_id INT PRIMARY KEY,
    nev NVARCHAR(100) NOT NULL,
    ar INT NOT NULL,
    ido_perc INT
);
INSERT INTO Szolgaltatas (szolgaltatas_id, nev, ar, ido_perc) VALUES
(1, 'Női hajvágás', 5000, 45),
(2, 'Férfi hajvágás', 3500, 30),
(3, 'Hajfestés', 12000, 90),
(4, 'Hajformázás', 4000, 30);


--Időpont tábla létrehozása és adatokkal való feltöltése:

CREATE TABLE Idopont (
    idopont_id INT PRIMARY KEY,
    ugyfel_id INT,
    fodrasz_id INT,
    szolgaltatas_id INT,
    datum TEXT,
    idopont TEXT,
    FOREIGN KEY (ugyfel_id) REFERENCES Ugyfel(ugyfel_id),
    FOREIGN KEY (fodrasz_id) REFERENCES Fodrasz(fodrasz_id),
    FOREIGN KEY (szolgaltatas_id) REFERENCES Szolgaltatas(szolgaltatas_id)
);
INSERT INTO Idopont (idopont_id, ugyfel_id, fodrasz_id, szolgaltatas_id, datum, idopont) VALUES
(1, 1, 1, 1, '2025-05-20', '09:00'),
(2, 1, 2, 2, '2025-05-20', '10:00'),
(3, 1, 3, 3, '2025-05-20', '11:00'),
(4, 2, 1, 2, '2025-05-21', '09:00'),
(5, 2, 2, 3, '2025-05-21', '10:00'),
(6, 2, 3, 1, '2025-05-21', '11:00'),
(7, 3, 1, 3, '2025-05-22', '09:00'),
(8, 3, 2, 1, '2025-05-22', '10:00'),
(9, 3, 3, 2, '2025-05-22', '11:00');


--Fizetés tábla létrehozása és adatokkal való feltöltése:

CREATE TABLE Fizetes (
    fizetes_id INT PRIMARY KEY,
    idopont_id INT,
    fizetesi_mod NVARCHAR(20),
    osszeg INT,
    datum TEXT,
    FOREIGN KEY (idopont_id) REFERENCES Idopont(idopont_id)
);
INSERT INTO Fizetes (fizetes_id, idopont_id, osszeg, fizetesi_mod, datum) VALUES
(1, 1, 5000, 'Készpénz', '2025-05-20'),
(2, 2, 8000, 'Bankkártya', '2025-05-20'),
(3, 3, 6500, 'Készpénz', '2025-05-20'),
(4, 4, 8000, 'Bankkártya', '2025-05-21'),
(5, 5, 6500, 'Készpénz', '2025-05-21'),
(6, 6, 5000, 'Bankkártya', '2025-05-21'),
(7, 7, 6500, 'Készpénz', '2025-05-22'),
(8, 8, 5000, 'Készpénz', '2025-05-22'),
(9, 9, 8000, 'Bankkártya', '2025-05-22');
