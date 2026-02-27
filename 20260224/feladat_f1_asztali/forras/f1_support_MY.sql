-- f1_support_MY.sql
-- Formula 1 – Race Control SupportDesk (asztali) forrás SQL
-- Kódolás: utf8mb4

DROP DATABASE IF EXISTS f1_support;
CREATE DATABASE f1_support CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci;
USE f1_support;

CREATE TABLE csapat (
  csapat_id INT AUTO_INCREMENT PRIMARY KEY,
  nev VARCHAR(50) NOT NULL,
  motor VARCHAR(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

CREATE TABLE pilota (
  pilota_id INT AUTO_INCREMENT PRIMARY KEY,
  csapat_id INT NOT NULL,
  nev VARCHAR(50) NOT NULL,
  rajtszam INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

CREATE TABLE futam (
  futam_id INT AUTO_INCREMENT PRIMARY KEY,
  nev VARCHAR(60) NOT NULL,
  datum DATE NOT NULL,
  palya VARCHAR(40) NOT NULL,
  orszag VARCHAR(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

CREATE TABLE esemeny (
  esemeny_id INT AUTO_INCREMENT PRIMARY KEY,
  futam_id INT NOT NULL,
  pilota_id INT NULL,
  kor INT NOT NULL,
  tipus VARCHAR(20) NOT NULL,      -- incident/penalty/radio/flag
  leiras VARCHAR(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

CREATE TABLE tisztviselo (
  tisztviselo_id INT AUTO_INCREMENT PRIMARY KEY,
  nev VARCHAR(50) NOT NULL,
  szint VARCHAR(10) NOT NULL       -- junior/medior/senior
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

CREATE TABLE jegy (
  jegy_id INT AUTO_INCREMENT PRIMARY KEY,
  cim VARCHAR(80) NOT NULL,
  status VARCHAR(20) NOT NULL,     -- open/investigating/resolved/closed
  tisztviselo_id INT NULL,
  esemeny_id INT NULL,
  sulyossag INT NOT NULL,          -- 1..5
  datum DATE NOT NULL,
  leiras VARCHAR(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- FK-kat a feladat szerint hozza létre (ON UPDATE CASCADE):
-- pilota.csapat_id -> csapat.csapat_id (RESTRICT)
-- esemeny.futam_id -> futam.futam_id (RESTRICT)
-- esemeny.pilota_id -> pilota.pilota_id (SET NULL)
-- jegy.tisztviselo_id -> tisztviselo.tisztviselo_id (SET NULL)
-- jegy.esemeny_id -> esemeny.esemeny_id (SET NULL)

INSERT INTO csapat(nev, motor) VALUES
('Red Falcon Racing','RBPT'),
('Silver Arrow GP','Mercedes'),
('Prancing Stallion','Ferrari'),
('Blue Wave Motorsport','Renault');

INSERT INTO pilota(csapat_id, nev, rajtszam) VALUES
(1,'Nagy Bálint',11),
(1,'Kiss Levente',55),
(2,'Alex Turner',63),
(3,'Marco Bianchi',16),
(4,'Sato Haru',22);

INSERT INTO futam(nev, datum, palya, orszag) VALUES
('Ausztrál Nagydíj','2026-03-15','Albert Park','Ausztrália'),
('Olasz Nagydíj','2026-04-12','Monza','Olaszország'),
('Monacói Nagydíj','2026-05-24','Monte Carlo','Monaco');

INSERT INTO esemeny(futam_id, pilota_id, kor, tipus, leiras) VALUES
(1,1,12,'incident','Koccanás a 3-as kanyar kijáratánál.'),
(1,3,25,'radio','Rádió probléma, csapat nem hallja a pilótát.'),
(2,4,8,'flag','Sárga zászló a 2-es szektorban.'),
(2,NULL,0,'penalty','Boxutcai gyorshajtás gyanú (vizsgálat).'),
(3,5,33,'incident','Fal érintés, első szárny sérülés.');

INSERT INTO tisztviselo(nev, szint) VALUES
('Bokor Kinga','senior'),
('Nóri','junior'),
('Ádám','medior'),
('Réka','senior');

INSERT INTO jegy(cim, status, tisztviselo_id, esemeny_id, sulyossag, datum, leiras) VALUES
('Safety Car döntés késik','open',1,1,4,'2026-03-15','Az incidens után késve érkezett SC döntés.'),
('Rádió csatorna szinkron hiba','investigating',4,2,3,'2026-03-15','A rádió üzenetek késve jelennek meg.'),
('Zászló jelzés eltérés','resolved',3,3,2,'2026-04-12','A televíziós grafika eltér a pályán jelzettől.'),
('Boxutcai penalty ellenőrzés','open',NULL,4,5,'2026-04-12','A rendszer nem rendelt automatikusan vizsgálót.'),
('Monaco telemetria hiány','closed',1,5,1,'2026-05-24','Rövid idejű adatkimaradás, javítva.');
