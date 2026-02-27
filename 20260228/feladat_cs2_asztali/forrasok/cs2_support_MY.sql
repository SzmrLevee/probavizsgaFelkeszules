-- cs2_support_MY.sql
-- Counter-Strike 2 – SupportDesk (asztali) forrás SQL
-- Kódolás: utf8mb4
-- EF Core Scaffold után a generált fájlokat ne módosítsa, partial class-szal bővítsen!

DROP DATABASE IF EXISTS cs2_support;
CREATE DATABASE cs2_support CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci;
USE cs2_support;

CREATE TABLE szervezet (
  szervezet_id INT AUTO_INCREMENT PRIMARY KEY,
  nev VARCHAR(60) NOT NULL,
  regio VARCHAR(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

CREATE TABLE csapat (
  csapat_id INT AUTO_INCREMENT PRIMARY KEY,
  szervezet_id INT NOT NULL,
  nev VARCHAR(50) NOT NULL,
  vilagrang INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

CREATE TABLE jatekos (
  jatekos_id INT AUTO_INCREMENT PRIMARY KEY,
  csapat_id INT NOT NULL,
  nev VARCHAR(50) NOT NULL,
  szerep VARCHAR(20) NOT NULL,     -- entry/awp/support/igl/lurk
  rating DECIMAL(3,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

CREATE TABLE meccs (
  meccs_id INT AUTO_INCREMENT PRIMARY KEY,
  datum DATE NOT NULL,
  palya VARCHAR(30) NOT NULL,
  tipus VARCHAR(20) NOT NULL,      -- ranked/major/showmatch
  csapat_a_id INT NOT NULL,
  csapat_b_id INT NOT NULL,
  eredmeny VARCHAR(10) NULL        -- pl. 13-9
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

CREATE TABLE ugyintezo (
  ugyintezo_id INT AUTO_INCREMENT PRIMARY KEY,
  nev VARCHAR(50) NOT NULL,
  szint VARCHAR(10) NOT NULL       -- junior/medior/senior
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

CREATE TABLE jegy (
  jegy_id INT AUTO_INCREMENT PRIMARY KEY,
  cim VARCHAR(80) NOT NULL,
  status VARCHAR(20) NOT NULL,     -- open/investigating/resolved/closed
  ugyintezo_id INT NULL,
  meccs_id INT NULL,
  sulyossag INT NOT NULL,          -- 1..5
  datum DATE NOT NULL,
  leiras VARCHAR(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- FK-kat a feladat szerint hozza létre (ON UPDATE CASCADE):
-- csapat.szervezet_id -> szervezet.szervezet_id (RESTRICT)
-- jatekos.csapat_id -> csapat.csapat_id (RESTRICT)
-- meccs.csapat_a_id -> csapat.csapat_id (RESTRICT)
-- meccs.csapat_b_id -> csapat.csapat_id (RESTRICT)
-- jegy.ugyintezo_id -> ugyintezo.ugyintezo_id (SET NULL)
-- jegy.meccs_id -> meccs.meccs_id (SET NULL)

INSERT INTO szervezet(nev, regio) VALUES
('Apex Esports','EU'),
('Sunrise Gaming','NA'),
('Kintsugi Clan','ASIA');

INSERT INTO csapat(szervezet_id, nev, vilagrang) VALUES
(1,'Apex',6),
(1,'Apex Academy',32),
(2,'Sunrise',12),
(3,'Kintsugi',18);

INSERT INTO jatekos(csapat_id, nev, szerep, rating) VALUES
(1,'Varga Áron','igl',1.12),
(1,'Kovács Máté','awp',1.19),
(3,'Noah Reed','entry',1.08),
(4,'Sato Kenji','support',1.05),
(2,'Tóth Dániel','lurk',1.01);

INSERT INTO meccs(datum, palya, tipus, csapat_a_id, csapat_b_id, eredmeny) VALUES
('2026-03-01','Mirage','ranked',1,3,'13-9'),
('2026-03-02','Inferno','major',1,4,NULL),
('2026-03-03','Nuke','showmatch',2,3,'13-11');

INSERT INTO ugyintezo(nev, szint) VALUES
('Bokor Kinga','senior'),
('Nóri','junior'),
('Ádám','medior'),
('Réka','senior');

INSERT INTO jegy(cim, status, ugyintezo_id, meccs_id, sulyossag, datum, leiras) VALUES
('Matchmaking szerver lag','open',1,1,4,'2026-03-01','Több játékosnál csomagvesztés és magas ping jelentkezik.'),
('Inventory szinkron hiba','investigating',4,NULL,3,'2026-02-28','A kozmetikai tárgyak késleltetve jelennek meg.'),
('Anti-cheat téves riasztás','resolved',3,3,5,'2026-03-03','Legitim játékos került ellenőrzés alá, feloldva.'),
('Eredmény nem mentődött','closed',1,1,2,'2026-03-01','A meccs vége után nem frissült a statisztika.'),
('Nincs ügyintéző rendelve','open',NULL,2,2,'2026-03-02','Major meccs előtt hibajegy érkezett, kiosztás hiányzik.');
