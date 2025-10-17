# AeroLink Togo 🛩️

Plateforme intelligente de gestion et prédiction de trafic aérien local pour le Togo.
mm
## 📋 Vue d'ensemble

AeroLink est une API REST développée avec FastAPI permettant de gérer les opérations aéroportuaires locales incluant :
- Gestion des vols domestiques
- Suivi des avions et de leurs capacités
- Gestion des passagers
- Gestion du fret
- Suivi météorologique des aéroports
- Géolocalisation des aéroports (avec PostGIS)

## 🏗️ Architecture du projet.

```
aerolink-togo/
│
├── backend/
│   ├── app/
│   │   ├── main.py                 # Point d'entrée de l'application
│   │   ├── database.py             # Configuration SQLAlchemy et session DB
│   │   ├── routers/                # Endpoints API
│   │   │   └── airports.py         # Routes pour les aéroports
│   │   ├── models/                 # Modèles SQLAlchemy (ORM)
│   │   │   └── airports.py         # Modèle Airport avec géolocalisation
│   │   └── schemas/                # Schémas Pydantic (validation)
│   │       └── airports.py         # Schémas de validation Airport
│   └── requirements                # Dépendances Python
│
├── database/
│   ├── shema.sql                   # Schéma de base (Avions, Vols, Passagers, Fret, Météo)
│   └── seed_data.sql               # Données de test
│
├── .vscode/
│   └── settings.json               # Configuration SQLTools
│
└── docs/
    └── shéma.md                    # Structure du projet (avec modules à développer)
```

## 🔧 Prérequis

- Python 3.8+
- PostgreSQL 12+ avec extension PostGIS
- Node.js 16+ (pour le frontend - à développer)

## 🚀 Installation

### 1. Base de données

```bash
# Créer la base de données PostgreSQL
createdb aerolink

# Se connecter à PostgreSQL
psql -d aerolink

# Activer l'extension PostGIS
CREATE EXTENSION postgis;

# Créer les tables
\i database/shema.sql

# Insérer les données de test
\i database/seed_data.sql
```

### 2. Backend

```bash
# Se placer dans le dossier backend
cd backend

# Créer un environnement virtuel
python -m venv venv

# Activer l'environnement virtuel
# Linux/Mac:
source venv/bin/activate
# Windows:
venv\Scripts\activate

# Installer les dépendances
pip install -r requirements

# Créer un fichier .env
echo "DATABASE_URL=postgresql://prince:votre_mot_de_passe@localhost:5432/aerolink" > .env

# Lancer le serveur
uvicorn app.main:app --reload
```

L'API sera accessible sur `http://localhost:8000`

Documentation interactive : `http://localhost:8000/docs`

## 📊 Modèle de données actuel

### Tables existantes (schema.sql)
- **avions** : Modèles d'avions et capacités
- **vols** : Vols avec départ, arrivée, dates, statut
- **passagers** : Informations des passagers
- **fret** : Gestion du fret par vol
- **meteo** : Données météorologiques par aéroport

### Tables implémentées dans l'API
- **airports** : Aéroports avec géolocalisation PostGIS (code IATA, nom, ville, pays, coordonnées)

## 🛠️ Modules à développer

D'après la structure prévue dans `docs/shéma.md`, voici ce qu'il reste à implémenter :

### Backend - Routers manquants
- `routers/vols.py` - Gestion des vols
- `routers/avions.py` - Gestion des avions
- `routers/passagers.py` - Gestion des passagers
- `routers/fret.py` - Gestion du fret
- `routers/meteo.py` - Gestion des données météo

### Backend - Models manquants
- `models/vols.py`
- `models/avions.py`
- `models/passagers.py`
- `models/fret.py`
- `models/meteo.py`

### Backend - Schemas manquants
- `schemas/vols.py`
- `schemas/avions.py`
- `schemas/passagers.py`
- `schemas/fret.py`
- `schemas/meteo.py`

### Frontend
```
frontend/
├── src/
│   ├── components/      # Composants réutilisables
│   ├── pages/           # Pages de l'application
│   ├── services/        # Appels API
│   └── utils/           # Utilitaires
└── package.json
```

**Technologies suggérées** :
- React avec TypeScript
- TailwindCSS pour le styling
- React Query pour la gestion des données
- Mapbox/Leaflet pour la visualisation des cartes

### Module IA
```
ai/
├── train_model.py       # Entraînement du modèle
├── predict.py           # Prédictions
├── data/                # Datasets
└── models/              # Modèles sauvegardés
```

**Fonctionnalités IA à développer** :
- Prédiction du trafic aérien
- Optimisation des plannings de vol
- Prédiction météorologique
- Détection d'anomalies

## 📡 API Endpoints actuels

### Airports
- `POST /airports/` - Créer un aéroport
- `GET /airports/` - Lister les aéroports (pagination)

### Exemple de requête

```bash
# Créer un aéroport
curl -X POST "http://localhost:8000/airports/" \
  -H "Content-Type: application/json" \
  -d '{
    "code": "LFW",
    "name": "Aéroport International Gnassingbé Eyadema",
    "city": "Lomé",
    "country": "Togo",
    "location": {
      "lat": 6.1656,
      "lon": 1.2544
    }
  }'
```

## 🔐 Configuration

### Variables d'environnement (.env)
```env
DATABASE_URL=postgresql://utilisateur:mot_de_passe@localhost:5432/aerolink
SECRET_KEY=votre_clé_secrète_ici
ALGORITHM=HS256
```

## 📝 Guide de développement

### Ajouter un nouveau module

1. **Créer le modèle** dans `models/`
```python
from sqlalchemy import Column, Integer, String
from ..database import Base

class Avion(Base):
    __tablename__ = "avions"
    id_avion = Column(Integer, primary_key=True)
    modele = Column(String(50), nullable=False)
    capacite = Column(Integer, nullable=False)
```

2. **Créer les schémas Pydantic** dans `schemas/`
```python
from pydantic import BaseModel

class AvionBase(BaseModel):
    modele: str
    capacite: int

class AvionCreate(AvionBase):
    pass

class Avion(AvionBase):
    id_avion: int
    class Config:
        orm_mode = True
```

3. **Créer le router** dans `routers/`
```python
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from ..database import get_db

router = APIRouter(prefix="/avions", tags=["avions"])

@router.get("/")
def get_avions(db: Session = Depends(get_db)):
    # Votre logique ici
    pass
```

4. **Enregistrer le router** dans `main.py`
```python
from .routers import avions
app.include_router(avions.router)
```

## 🧪 Tests

```bash
# À développer
pytest tests/
```

## 📦 Déploiement

Suggestions pour la mise en production :
- **Backend** : Docker + Heroku/Railway/Render
- **Base de données** : PostgreSQL managé (AWS RDS, Supabase)
- **Frontend** : Vercel/Netlify

## 🤝 Contribution

1. Fork le projet
2. Créer une branche (`git checkout -b feature/nouvelle-fonctionnalite`)
3. Commit les changements (`git commit -m 'Ajout nouvelle fonctionnalité'`)
4. Push vers la branche (`git push origin feature/nouvelle-fonctionnalite`)
5. Ouvrir une Pull Request

## 📄 Licence

À définir

## 👥 Auteur

Prince - Projet AeroLink Togo

## 🗺️ Roadmap

- [ ] Implémenter tous les routers (vols, avions, passagers, fret, météo)
- [ ] Développer le frontend React
- [ ] Ajouter l'authentification JWT
- [ ] Intégrer les API météo en temps réel
- [ ] Développer les modèles de prédiction IA
- [ ] Ajouter les tests unitaires et d'intégration
- [ ] Créer un tableau de bord analytics
- [ ] Intégrer un système de notifications
- [ ] Déployer en production

---

**Note** : Ce projet est actuellement en développement actif. La structure de base est en place, mais de nombreuses fonctionnalités restent à implémenter selon le plan défini dans `docs/shéma.md`.je serai vraiment ravie reconnaissant si vous m'apportiez votre aide 
