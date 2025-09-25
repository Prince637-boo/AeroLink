from sqlalchemy import Column, Integer, String
from geoalchemy2 import Geography
from ..database import Base

class Airport(Base):
    __tablename__ = "airports"

    id = Column(Integer, primary_key=True, index=True)
    code = Column(String(10), unique=True, nullable=False, index=True)
    name = Column(String(100))
    city = Column(String(100))
    country = Column(String(100))
    location = Column(Geography(geometry_type='POINT', srid=4326))

