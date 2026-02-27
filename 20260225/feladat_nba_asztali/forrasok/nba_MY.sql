-- nba_MY.sql
-- NBA (asztali) – forrás SQL
-- Kódolás: utf8mb4
-- FIGYELEM: A foreign key kapcsolatok beállítását a feladatleírás alapján kell elvégezni az adatbázisban.

DROP DATABASE IF EXISTS nba_market;
CREATE DATABASE nba_market CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci;
USE nba_market;

CREATE TABLE kategoria (
  kategoria_id INT AUTO_INCREMENT PRIMARY KEY,
  megnevezes VARCHAR(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

CREATE TABLE termek (
  termek_id INT AUTO_INCREMENT PRIMARY KEY,
  kategoria_id INT NOT NULL,
  nev VARCHAR(60) NOT NULL,
  csapat VARCHAR(40) NOT NULL,
  leiras VARCHAR(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

CREATE TABLE elado (
  elado_id INT AUTO_INCREMENT PRIMARY KEY,
  nev VARCHAR(50) NOT NULL,
  varos VARCHAR(40) NOT NULL,
  ertekeles INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

CREATE TABLE hirdetes (
  hirdetes_id INT AUTO_INCREMENT PRIMARY KEY,
  termek_id INT NOT NULL,
  elado_id INT NOT NULL,
  mikortol DATE NOT NULL,
  meddig DATE NULL,
  ar INT NOT NULL,
  keszlet INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

INSERT INTO kategoria(megnevezes) VALUES
('Mez (Jersey)'),
('Cipő'),
('Kártya'),
('Relikvia');

INSERT INTO termek(kategoria_id, nev, csapat, leiras) VALUES
(1,'City Edition mez','Los Angeles Lakers','Limitált kiadású mez, eredeti címkékkel.'),
(1,'Statement mez','Boston Celtics','Zöld-fehér mez, gyűjtői állapot.'),
(2,'Signature cipő','Dallas Mavericks','Aláírásos kosárlabdacipő, 44-es méret.'),
(2,'Retro cipő','Chicago Bulls','Klasszikus retro modell, megkímélt állapot.'),
(3,'Rookie kártya','San Antonio Spurs','Újonc kártya, védőtokkal.'),
(3,'All-Star kártya','Golden State Warriors','All-Star válogatott kártya, jó állapot.'),
(4,'Aláírt labda','Miami Heat','Hitelesített aláírás, vitrinbe való.'),
(4,'Parketta darab','New York Knicks','Arénából származó relikvia (emlék).');

INSERT INTO elado(nev, varos, ertekeles) VALUES
('Marci','Budapest',5),
('Noémi','Szeged',4),
('Áron','Debrecen',5),
('Lilla','Pécs',4),
('Zsombor','Győr',3);

INSERT INTO hirdetes(termek_id, elado_id, mikortol, meddig, ar, keszlet) VALUES
(1, 1, '2026-02-01', NULL, 32000, 4),
(2, 2, '2026-02-05', '2026-02-22', 28000, 2),
(3, 3, '2026-01-28', NULL, 45000, 1),
(4, 4, '2026-02-10', NULL, 38000, 1),
(5, 5, '2026-02-03', '2026-02-18', 12000, 6),
(6, 1, '2026-02-07', NULL, 9000, 8),
(7, 2, '2026-01-20', NULL, 60000, 1),
(8, 3, '2026-02-02', '2026-02-16', 15000, 3);
