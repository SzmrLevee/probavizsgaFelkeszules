-- fifa2026_support_MY.sql
-- FIFA Világbajnokság 2026 – SupportDesk (asztali) forrás SQL
-- Kódolás: utf8mb4
-- FIGYELEM: EF Core Scaffold után a generált fájlokat ne módosítsa, partial class-szal bővítsen!

DROP DATABASE IF EXISTS fifa2026_support;
CREATE DATABASE fifa2026_support CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci;
USE fifa2026_support;

CREATE TABLE csoport (
  csoport_id INT AUTO_INCREMENT PRIMARY KEY,
  jel CHAR(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

CREATE TABLE csapat (
  csapat_id INT AUTO_INCREMENT PRIMARY KEY,
  csoport_id INT NOT NULL,
  nev VARCHAR(60) NOT NULL,
  fifa_rang INT NOT NULL,
  kontinens VARCHAR(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

CREATE TABLE merkozes (
  merkozes_id INT AUTO_INCREMENT PRIMARY KEY,
  datum DATE NOT NULL,
  varos VARCHAR(40) NOT NULL,
  stadion VARCHAR(60) NOT NULL,
  hazai_csapat_id INT NOT NULL,
  vendeg_csapat_id INT NOT NULL,
  hazai_gol INT NULL,
  vendeg_gol INT NULL,
  fazis VARCHAR(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

CREATE TABLE ugyintezo (
  ugyintezo_id INT AUTO_INCREMENT PRIMARY KEY,
  nev VARCHAR(50) NOT NULL,
  szint VARCHAR(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

CREATE TABLE hibajegy (
  hibajegy_id INT AUTO_INCREMENT PRIMARY KEY,
  cim VARCHAR(80) NOT NULL,
  status VARCHAR(20) NOT NULL,
  ugyintezo_id INT NULL,
  merkozes_id INT NULL,
  sulyossag INT NOT NULL,
  datum DATE NOT NULL,
  leiras VARCHAR(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- Kapcsolatok (FK) – a feladatban hozza létre, de itt is megadható:
-- csapat.csoport_id -> csoport.csoport_id
-- merkozes.hazai_csapat_id -> csapat.csapat_id
-- merkozes.vendeg_csapat_id -> csapat.csapat_id
-- hibajegy.ugyintezo_id -> ugyintezo.ugyintezo_id (SET NULL)
-- hibajegy.merkozes_id -> merkozes.merkozes_id (SET NULL)

INSERT INTO csoport(jel) VALUES ('A'),('B'),('C'),('D');

INSERT INTO csapat(csoport_id, nev, fifa_rang, kontinens) VALUES
(1,'Magyarország',35,'UEFA'),
(1,'Németország',15,'UEFA'),
(1,'Mexikó',12,'CONCACAF'),
(1,'Japán',18,'AFC'),
(2,'Brazília',3,'CONMEBOL'),
(2,'Spanyolország',7,'UEFA'),
(2,'Kamerun',40,'CAF'),
(2,'Ausztrália',24,'AFC'),
(3,'Franciaország',2,'UEFA'),
(3,'Argentína',1,'CONMEBOL'),
(3,'USA',11,'CONCACAF'),
(3,'Dél-Korea',22,'AFC'),
(4,'Anglia',4,'UEFA'),
(4,'Olaszország',9,'UEFA'),
(4,'Marokkó',14,'CAF'),
(4,'Kanada',28,'CONCACAF');

INSERT INTO merkozes(datum, varos, stadion, hazai_csapat_id, vendeg_csapat_id, hazai_gol, vendeg_gol, fazis) VALUES
('2026-06-12','Dallas','AT&T Stadium',2,1,2,0,'csoport'),
('2026-06-13','Los Angeles','SoFi Stadium',3,4,1,1,'csoport'),
('2026-06-14','New York','MetLife Stadium',5,6,2,2,'csoport'),
('2026-06-15','Miami','Hard Rock Stadium',9,10,1,2,'csoport'),
('2026-06-16','Seattle','Lumen Field',13,14,NULL,NULL,'csoport'),
('2026-06-18','Toronto','BMO Field',15,16,NULL,NULL,'csoport');

INSERT INTO ugyintezo(nev, szint) VALUES
('Bokor Kinga','senior'),
('Nóri','junior'),
('Ádám','medior'),
('Réka','senior');

INSERT INTO hibajegy(cim, status, ugyintezo_id, merkozes_id, sulyossag, datum, leiras) VALUES
('Belépő QR-kód nem működik','open',1,1,4,'2026-06-12','A kapunál a QR-kód beolvasás sikertelen.'),
('Dupla terhelés a jegyvásárlásnál','investigating',4,3,5,'2026-06-14','A banki kivonaton kétszer szerepel a tranzakció.'),
('Rossz ülőhely kiosztás','resolved',3,2,3,'2026-06-13','A jegyen szereplő szektor eltér a rendszerben tárolttól.'),
('VIP csomag késik','open',NULL,4,2,'2026-06-15','A csomag átvétele csúszik, ügyintéző még nincs rendelve.'),
('Stadion térkép hibás link','closed',1,NULL,1,'2026-06-10','A weboldalon a stadion térkép linkje hibás.');
