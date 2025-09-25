from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List

from app.models.airports import Airport
from app.schemas.airports import Airport as AirportModel, AirportCreate

from ..database import get_db

router = APIRouter(
    prefix="/airports",
    tags=["airports"],
)

@router.post("/", response_model=AirportModel)
def create_airport(airport: AirportCreate, db: Session = Depends(get_db)):
    wkt_location = f'POINT({airport.location.lon} {airport.location.lat})'
    db_airport = Airport(**airport.dict(exclude={"location"}), location=wkt_location)
    db.add(db_airport)
    db.commit()
    db.refresh(db_airport)
    return db_airport

@router.get("/", response_model=List[AirportModel])
def read_airports(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    airports = db.query(Airport).offset(skip).limit(limit).all()
    return airports

