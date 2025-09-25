-- ========================================
-- Table Avions
-- ========================================
INSERT INTO avions (modele, capacite) VALUES
('ATR 72', 70),
('Cessna 208', 12),
('Boeing 737', 180);

-- ========================================
-- Table Vols
-- ========================================
INSERT INTO vols (depart, arrivee, date_depart, date_arrivee, statut, id_avion) VALUES
('Lomé','Kara','2025-09-25 10:00','2025-09-25 11:30','prévu',1),
('Lomé','Sokodé','2025-09-25 12:00','2025-09-25 13:00','prévu',2),
('Lomé','Dapaong','2025-09-26 09:00','2025-09-26 11:00','prévu',3);

-- ========================================
-- Table Passagers
-- ========================================
INSERT INTO passagers (nom, prenom, email, telephone) VALUES
('Doe','John','john.doe@example.com','+22890000001'),
('Smith','Jane','jane.smith@example.com','+22890000002'),
('Kossi','Amey','amey.kossi@example.tg','+22890000003');

-- ========================================
-- Table Fret
-- ========================================
INSERT INTO fret (description, poids, id_vol) VALUES
('Fruits frais', 120.5, 1),
('Textiles', 200.0, 2),
('Médicaments', 50.0, 3);

-- ========================================
-- Table Météo
-- ========================================
INSERT INTO meteo (aeroport, temperature, humidite, vent, date_enregistrement) VALUES
('Lomé', 32.5, 70, 12, '2025-09-24 08:00'),
('Kara', 30.0, 65, 10, '2025-09-24 08:15'),
('Sokodé', 31.2, 68, 8, '2025-09-24 08:30'),
('Dapaong', 29.8, 60, 15, '2025-09-24 08:45');
