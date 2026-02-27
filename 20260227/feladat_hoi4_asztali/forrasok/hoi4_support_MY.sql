-- hoi4_support_MY.sql
-- Hearts of Iron IV – War Room SupportDesk (asztali) forrás SQL
-- Kódolás: utf8mb4

DROP DATABASE IF EXISTS hoi4_support;
CREATE DATABASE hoi4_support CHARACTER SET utf8mb4 COLLATE utf8mb4_hungarian_ci;
USE hoi4_support;

CREATE TABLE frakcio (
  frakcio_id INT AUTO_INCREMENT PRIMARY KEY,
  nev VARCHAR(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

CREATE TABLE orszag (
  orszag_id INT AUTO_INCREMENT PRIMARY KEY,
  frakcio_id INT NOT NULL,
  nev VARCHAR(50) NOT NULL,
  ip INT NOT NULL,
  manpower INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

CREATE TABLE hadmuvelet (
  hadmuvelet_id INT AUTO_INCREMENT PRIMARY KEY,
  nev VARCHAR(60) NOT NULL,
  kezdet DATE NOT NULL,
  vege DATE NULL,
  szinter VARCHAR(20) NOT NULL,
  orszag_id INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

CREATE TABLE tiszt (
  tiszt_id INT AUTO_INCREMENT PRIMARY KEY,
  nev VARCHAR(50) NOT NULL,
  rang VARCHAR(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

CREATE TABLE incidens (
  incidens_id INT AUTO_INCREMENT PRIMARY KEY,
  cim VARCHAR(80) NOT NULL,
  status VARCHAR(20) NOT NULL,
  tiszt_id INT NULL,
  hadmuvelet_id INT NULL,
  sulyossag INT NOT NULL,
  datum DATE NOT NULL,
  leiras VARCHAR(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_hungarian_ci;

-- FK-kat a feladat szerint hozza létre:
-- orszag.frakcio_id -> frakcio.frakcio_id (RESTRICT)
-- hadmuvelet.orszag_id -> orszag.orszag_id (RESTRICT)
-- incidens.tiszt_id -> tiszt.tiszt_id (SET NULL)
-- incidens.hadmuvelet_id -> hadmuvelet.hadmuvelet_id (SET NULL)

INSERT INTO frakcio(nev) VALUES
('Szövetségesek'),
('Tengely'),
('Komintern'),
('Semleges');

INSERT INTO orszag(frakcio_id, nev, ip, manpower) VALUES
(1,'Egyesült Királyság',120,900),
(1,'USA',180,1200),
(2,'Németország',160,1100),
(2,'Olaszország',90,700),
(3,'Szovjetunió',200,1500),
(4,'Svédország',60,300);

INSERT INTO hadmuvelet(nev, kezdet, vege, szinter, orszag_id) VALUES
('Overlord előkészítés','1939-09-10',NULL,'land',1),
('Konvojvédelem','1939-10-01',NULL,'naval',1),
('Barbarossa logisztika','1941-06-22',NULL,'land',3),
('Légi fölény – Keleti front','1941-07-01',NULL,'air',5);

INSERT INTO tiszt(nev, rang) VALUES
('Bokor Kinga','tábornok'),
('Nóri','őrnagy'),
('Ádám','ezredes'),
('Réka','tábornok');

INSERT INTO incidens(cim, status, tiszt_id, hadmuvelet_id, sulyossag, datum, leiras) VALUES
('Ellátmány hiány a fronton','open',1,3,5,'1941-06-25','A vasúti csomópont túlterhelt, a hadosztályok utánpótlása késik.'),
('Konvoj útvonal bug','investigating',4,2,3,'1939-10-03','A konvojok kerülő útvonalat választanak és időt veszítenek.'),
('Gyártósor leállás','resolved',3,NULL,2,'1939-09-15','A gyár kapacitás nem frissül megfelelően.'),
('Légi baleset jelentés','closed',1,4,1,'1941-07-05','A légi bevetések logja hibás, javítva.'),
('Tiszt nincs hozzárendelve','open',NULL,1,2,'1939-09-12','Az incidenshez még nincs kijelölt tiszt.');
