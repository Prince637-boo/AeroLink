from pydantic import BaseModel
from typing import Optional

# Schéma pour la création d'un point géographique
class Point(BaseModel):
    lat: float
    lon: float

# Schéma de base pour un aéroport
class AirportBase(BaseModel):
    code: str
    name: Optional[str] = None
    city: Optional[str] = None
    country: Optional[str] = None

# Schéma pour la création d'un aéroport (ce que l'API attend en entrée)
class AirportCreate(AirportBase):
    location: Point

# Schéma pour la lecture d'un aéroport (ce que l'API retourne)
class Airport(AirportBase):
    id: int
    class Config:
        orm_mode = True

