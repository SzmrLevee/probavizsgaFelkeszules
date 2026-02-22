-- LoL Support - Hibajegyek (MySQL)
-- Forrásfájl: lol_support_MY.sql

DROP DATABASE IF EXISTS lol_support;
CREATE DATABASE lol_support CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci;
USE lol_support;

-- Szerepek (Top/Jungle/Mid/ADC/Support)
DROP TABLE IF EXISTS szerep;
CREATE TABLE szerep (
  szerep_id INT AUTO_INCREMENT PRIMARY KEY,
  megnevezes VARCHAR(20) NOT NULL
) ENGINE=InnoDB;

-- Hősök (championok)
DROP TABLE IF EXISTS hos;
CREATE TABLE hos (
  hos_id INT AUTO_INCREMENT PRIMARY KEY,
  nev VARCHAR(30) NOT NULL,
  szerep_id INT NOT NULL,
  nyeresi_arany INT NOT NULL,         -- % (pl. 53)
  valasztasi_arany INT NOT NULL,      -- % (pl. 18)
  FOREIGN KEY (szerep_id) REFERENCES szerep(szerep_id)
) ENGINE=InnoDB;

-- Ügyintézők (support agentek)
DROP TABLE IF EXISTS ugyintezo;
CREATE TABLE ugyintezo (
  ugyintezo_id INT AUTO_INCREMENT PRIMARY KEY,
  nev VARCHAR(30) NOT NULL,
  regio VARCHAR(10) NOT NULL          -- pl. EUNE, EUW
) ENGINE=InnoDB;

-- Hibajegyek (ticketek)
DROP TABLE IF EXISTS hibajegy;
CREATE TABLE hibajegy (
  hibajegy_id INT AUTO_INCREMENT PRIMARY KEY,
  hos_id INT NULL,
  ugyintezo_id INT NULL,
  datum DATE NOT NULL,
  statusz VARCHAR(20) NOT NULL DEFAULT 'open', -- open, investigating, resolved, closed
  sulyossag INT NOT NULL,                      -- 1..5
  leiras VARCHAR(200) NOT NULL,
  FOREIGN KEY (hos_id) REFERENCES hos(hos_id) ON DELETE SET NULL,
  FOREIGN KEY (ugyintezo_id) REFERENCES ugyintezo(ugyintezo_id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- Adatok
INSERT INTO szerep (megnevezes) VALUES
('Top'), ('Jungle'), ('Mid'), ('ADC'), ('Support');

INSERT INTO hos (nev, szerep_id, nyeresi_arany, valasztasi_arany) VALUES
('Yasuo', 3, 51, 17),
('Zed', 3, 52, 14),
('Lee Sin', 2, 49, 16),
('Jinx', 4, 53, 21),
('Thresh', 5, 50, 13),
('Darius', 1, 54, 10),
('Katarina', 3, 53, 12),
('Kai''Sa', 4, 52, 18);

INSERT INTO ugyintezo (nev, regio) VALUES
('Kovacs Lilla', 'EUNE'),
('Kiss Bence', 'EUW'),
('Toth Zsofi', 'EUNE'),
('Szabo Mate', 'EUW');

-- Hibajegyek (LoL/Riot Client + balance jelleg)
INSERT INTO hibajegy (hos_id, ugyintezo_id, datum, statusz, sulyossag, leiras) VALUES
(NULL, 4, '2026-02-01', 'open', 4, 'Riot Client beragad a "Signing in..." allapotban, ujratelepites nem segit.'),
(NULL, 3, '2026-02-02', 'investigating', 5, 'VAN 128 hiba: Vanguard utan nem indul a League.'),
(1, 2, '2026-02-03', 'open', 3, 'Yasuo pick/ban arany tul magas, balansz felulvizsgalat (nerf javaslat).'),
(6, 2, '2026-02-03', 'open', 2, 'Darius lanen tul dominans alacsony MMR-en, kerunk vizsgalatot.'),
(4, 1, '2026-02-04', 'resolved', 3, 'Jinx meccs kozben crash: driver frissites utan megszunt.'),
(NULL, 1, '2026-02-04', 'closed', 1, 'Hang bug: eltunik az SFX, ujrainditas megoldotta.'),
(8, NULL, '2026-02-05', 'open', 2, 'Kai''Sa skin animacio hibas a recall alatt (vizualis bug).'),
(3, 4, '2026-02-05', 'closed', 2, 'Lee Sin Q hang kesik. Javitas utan rendben.'),
(5, 3, '2026-02-06', 'investigating', 4, 'Thresh hook hitbox gyanus, replayben elteres latszik.');
