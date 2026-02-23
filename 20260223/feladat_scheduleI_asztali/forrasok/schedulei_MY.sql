-- schedulei_MY.sql
-- ScheduleI (asztali) – forrás SQL
-- Kódolás: utf8mb4
-- FIGYELEM: A foreign key kapcsolatok beállítását a feladatleírás alapján kell elvégezni az adatbázisban.

DROP DATABASE IF EXISTS schedulei;
CREATE DATABASE schedulei CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci;
USE schedulei;

CREATE TABLE kategoria (
  kategoria_id INT AUTO_INCREMENT PRIMARY KEY,
  megnevezes VARCHAR(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

CREATE TABLE termek (
  termek_id INT AUTO_INCREMENT PRIMARY KEY,
  kategoria_id INT NOT NULL,
  nev VARCHAR(50) NOT NULL,
  thc_szazalek INT NOT NULL,
  leiras VARCHAR(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

CREATE TABLE dealer (
  dealer_id INT AUTO_INCREMENT PRIMARY KEY,
  nev VARCHAR(50) NOT NULL,
  terulet VARCHAR(40) NOT NULL,
  jutalek INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

CREATE TABLE hirdetes (
  hirdetes_id INT AUTO_INCREMENT PRIMARY KEY,
  termek_id INT NOT NULL,
  dealer_id INT NOT NULL,
  mikortol DATE NOT NULL,
  meddig DATE NULL,
  ar INT NOT NULL,
  mennyiseg INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

INSERT INTO kategoria(megnevezes) VALUES
('Virág (strain)'),
('Koncentrátum'),
('Edible'),
('Kiegészítő');

INSERT INTO termek(kategoria_id, nev, thc_szazalek, leiras) VALUES
(1,'OG Kush',24,'Klasszikus indica-domináns strain, erős relaxáló hatással.'),
(1,'Sour Diesel',22,'Energikus, sativa-domináns strain.'),
(1,'Blue Dream',20,'Kiegyensúlyozott hibrid, népszerű kezdőknek is.'),
(2,'Wax',70,'Magas THC-tartalmú koncentrátum.'),
(2,'Shatter',75,'Üvegszerű koncentrátum, nagyon erős.'),
(3,'Gummy (10mg)',10,'Egyszerű edible adagolással.'),
(3,'Brownie (20mg)',20,'Erősebb edible, lassabb felszívódás.'),
(4,'Grinder',0,'Őrlő, a feldolgozáshoz.'),
(4,'Rolling Papers',0,'Papír, sodráshoz.');

INSERT INTO dealer(nev, terulet, jutalek) VALUES
('Benjy','Downtown',12),
('Hector','Harbor',10),
('Mia','Uptown',15),
('Rico','Industrial',8),
('Tasha','Suburbs',11);

INSERT INTO hirdetes(termek_id, dealer_id, mikortol, meddig, ar, mennyiseg) VALUES
(1, 1, '2026-02-01', NULL, 4500, 30),
(2, 1, '2026-02-05', '2026-02-20', 4200, 20),
(3, 2, '2026-01-25', NULL, 3900, 25),
(4, 2, '2026-02-10', NULL, 6500, 10),
(5, 3, '2026-02-03', '2026-02-18', 7000, 8),
(6, 3, '2026-02-01', NULL, 1800, 40),
(7, 4, '2026-02-07', NULL, 2600, 18),
(1, 4, '2026-02-02', '2026-02-16', 4400, 15),
(9, 5, '2026-01-15', NULL, 500, 120),
(8, 5, '2026-02-01', '2026-02-12', 2500, 12);
