-- Table Avions
CREATE TABLE avions (
    id_avion SERIAL PRIMARY KEY,
    modele VARCHAR(50) NOT NULL,
    capacite INT NOT NULL
);

-- Table Vols
CREATE TABLE vols (
    id_vol SERIAL PRIMARY KEY,
    depart VARCHAR(50) NOT NULL,
    arrivee VARCHAR(50) NOT NULL,
    date_depart TIMESTAMP NOT NULL,
    date_arrivee TIMESTAMP NOT NULL,
    statut VARCHAR(20) NOT NULL,
    id_avion INT REFERENCES Avions(id_avion)
);

-- Table Passagers
CREATE TABLE passagers (
    id_passager SERIAL PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    telephone VARCHAR(20)
);

-- Table Fret
CREATE TABLE fret (
    id_fret SERIAL PRIMARY KEY,
    description VARCHAR(100),
    poids FLOAT,
    id_vol INT REFERENCES Vols(id_vol)
);

-- Table Météo
CREATE TABLE meteo(
    id_meteo SERIAL PRIMARY KEY,
    aeroport VARCHAR(50) NOT NULL,
    temperature FLOAT,
    humidite FLOAT,
    vent FLOAT,
    date_enregistrement TIMESTAMP DEFAULT NOW()
);
