from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from typing import Dict
from uuid import uuid4

app = FastAPI(title="RTech - Solicitações")
db: Dict[str, "Solicitacao"] = {} # em memória: {id: Solicitacao}

class SolicitacaoCreate(BaseModel):
    tipo: str
    descricao: str
    status: str = "Pendente"  # Pendente | Aprovada | Rejeitada

class Solicitacao(BaseModel):
    id: str
    tipo: str
    descricao: str
    status: str

@app.post("/solicitacoes", response_model=Solicitacao, status_code=201)
def criar(body: SolicitacaoCreate):
    new_id = str(uuid4())
    item = Solicitacao(id=new_id, **body.model_dump())
    db[new_id] = item
    return item

@app.get("/solicitacoes", response_model=list[Solicitacao])
def listar():
    return list(db.values())


@app.get("/solicitacoes/{id}", response_model=Solicitacao)
def buscar(id: str):
    item = db.get(id)
    if not item:
        raise HTTPException(status_code=404, detail="Solicitação não encontrada")
    return item

@app.put("/solicitacoes/{id}", response_model=Solicitacao)
def atualizar(id: str, body: SolicitacaoCreate):
    if id not in db:
        raise HTTPException(status_code=404, detail="Solicitação não encontrada")
    atualizado = Solicitacao(id=id, **body.model_dump())
    db[id] = atualizado
    return atualizado

@app.delete("/solicitacoes/{id}", status_code=204)
def deletar(id: str):
    if id not in db:
        raise HTTPException(status_code=404, detail="Solicitação não encontrada")
    del db[id]
    return None