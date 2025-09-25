from fastapi import FastAPI

from .database import engine
from .models import airports as airport_model
from .routers import airports as airport_router

# Crée les tables dans la base de données si elles n'existent pas
# Attention: En production, il est préférable d'utiliser des migrations (ex: Alembic)
airport_model.Base.metadata.create_all(bind=engine)

app = FastAPI(
    title="AeroLink API",
    description="API pour la gestion des opérations aéroportuaires.",
    version="0.1.0",
)

@app.get("/")
async def root():
    return {"message": "Bienvenue sur l'API AeroLink"}

app.include_router(airport_router.router)
