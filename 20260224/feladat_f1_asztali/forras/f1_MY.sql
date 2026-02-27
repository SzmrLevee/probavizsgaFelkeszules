-- f1_MY.sql
-- F1 Parts Bazaar (asztali) – forrás SQL
-- Kódolás: utf8mb4
-- FIGYELEM: A foreign key kapcsolatok beállítását a feladatleírás alapján kell elvégezni az adatbázisban.

DROP DATABASE IF EXISTS f1bazaar;
CREATE DATABASE f1bazaar CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci;
USE f1bazaar;

CREATE TABLE kategoria (
  kategoria_id INT AUTO_INCREMENT PRIMARY KEY,
  megnevezes VARCHAR(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

CREATE TABLE alkatresz (
  alkatresz_id INT AUTO_INCREMENT PRIMARY KEY,
  kategoria_id INT NOT NULL,
  nev VARCHAR(60) NOT NULL,
  kompatibilitas VARCHAR(60) NOT NULL,
  leiras VARCHAR(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

CREATE TABLE beszallito (
  beszallito_id INT AUTO_INCREMENT PRIMARY KEY,
  nev VARCHAR(50) NOT NULL,
  paddock_zona VARCHAR(40) NOT NULL,
  kedvezmeny_szazalek INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

CREATE TABLE ajanlat (
  ajanlat_id INT AUTO_INCREMENT PRIMARY KEY,
  alkatresz_id INT NOT NULL,
  beszallito_id INT NOT NULL,
  mikortol DATE NOT NULL,
  meddig DATE NULL,
  ar INT NOT NULL,
  raktaron INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

INSERT INTO kategoria(megnevezes) VALUES
('Aerodinamika'),
('Motor'),
('Elektronika'),
('Merch');

INSERT INTO alkatresz(kategoria_id, nev, kompatibilitas, leiras) VALUES
(1,'Front Wing (Spec-A)','2026 szabvány','Nagy leszorítóerő, gyors pályákra optimalizálva.'),
(1,'Rear Wing (Spec-L)','2026 szabvány','Alacsony légellenállás, hosszú egyenesekre.'),
(1,'Floor Edge Kit','2026 padló','Stabilabb áramlás, kevesebb pattogás.'),
(2,'ERS Battery Pack','V6 Hybrid','Nagy sűrűségű energiatárolás, verseny-spec.'),
(2,'Turbocharger Unit','V6 Hybrid','Gyorsabb spool, javított hőmenedzsment.'),
(2,'MGU-K Module','V6 Hybrid','Hatékonyabb energia-visszanyerés.'),
(3,'ECU (FIA Standard)','FIA ECU','Szoftveres telemetria + alap vezérlés.'),
(3,'Telemetry Antenna','Universal','Stabilabb adatkapcsolat a boxfalhoz.'),
(4,'Team Cap (Classic)','Univerzális','Hímzett logó, állítható pánt.'),
(4,'Pit Crew Gloves','Univerzális','Hőálló kesztyű gyors kerékcseréhez.');

INSERT INTO beszallito(nev, paddock_zona, kedvezmeny_szazalek) VALUES
('Apex Components','Garage Row',8),
('GridTech Supply','Media Center',5),
('VeloDynamics','Paddock Club',10),
('TorqueWorks','Hospitality',6),
('PitLane Merch','Fan Zone',12);

INSERT INTO ajanlat(alkatresz_id, beszallito_id, mikortol, meddig, ar, raktaron) VALUES
(1, 1, '2026-02-01', NULL, 1250000, 4),
(2, 1, '2026-02-05', '2026-02-20', 990000, 3),
(3, 3, '2026-01-25', NULL, 760000, 6),
(4, 2, '2026-02-10', NULL, 2100000, 2),
(5, 4, '2026-02-03', '2026-02-18', 1850000, 1),
(6, 4, '2026-02-01', NULL, 1450000, 2),
(7, 2, '2026-02-07', NULL, 320000, 10),
(8, 3, '2026-02-02', '2026-02-16', 180000, 12),
(9, 5, '2026-01-15', NULL, 6500, 120),
(10, 5, '2026-02-01', '2026-02-12', 24000, 25);
