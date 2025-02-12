from fastapi import FastAPI, Depends
from flask import session, jsonify
from sqlalchemy import create_engine, Column, Integer, String, ForeignKey, Double, or_, Date, select, func
from sqlalchemy.orm import sessionmaker, declarative_base, relationship, aliased
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from fastapi.responses import JSONResponse
from datetime import date
from confg import DATABASE_URL;

db = create_engine(DATABASE_URL, echo=True)
Session = sessionmaker(bind=db)

def get_session():
    session = Session()
    try:
        yield session
    finally:
        session.close()
base = declarative_base()

#classe cliente
class Cliente(base):
    __tablename__ = 'clientes'
    id = Column('id', Integer, primary_key=True, autoincrement=True)
    nome = Column('nome', String(100), nullable=False)
    cpf = Column('cpf', Integer, unique=True, nullable=False)
    email = Column('email', String(100), unique=True, nullable=False)
    senha = Column('senha', String(100), nullable=False)
    nivel = Column('nivel', Integer, nullable=False)
    idade = Column('idade', Integer)
    peso = Column('peso', Double)
    altura = Column('altura', Integer)

    treinos = relationship("Treino", back_populates="cliente")

    def __init__(self, nome, cpf, email, idade, peso, altura, senha, nivel):
        self.nome = nome
        self.cpf = cpf
        self.email = email
        self.senha = senha
        self.nivel = nivel
        self.idade = idade
        self.peso = peso
        self.altura = altura

#classe treino
class Treino(base):
    __tablename__ = 'treinos'
    id = Column('id', Integer, primary_key=True, autoincrement=True)
    id_cliente = Column('id_cliente', Integer, ForeignKey('clientes.id'), nullable=False)  
    nome = Column('nome', String(100), nullable=False)

    cliente = relationship("Cliente", back_populates="treinos")

    def __init__(self, id_cliente, nome):
        self.id_cliente = id_cliente
        self.nome = nome

#classe grupo muscular
class GrupoMuscular(base):
    __tablename__ = 'grupos_musculares'
    id = Column('id', Integer, primary_key=True, autoincrement=True)
    nome = Column('nome', String(100), nullable=False)

    exercicio = relationship("Exercicio", back_populates="grupo")

    def __init__(self, nome):
        self.nome = nome

#classe exercicio
class Exercicio(base):
    __tablename__ = 'exercicios'
    id = Column('id', Integer, primary_key=True, autoincrement=True)  
    nome = Column('nome', String(100), nullable=False)
    id_grupo = Column('id_grupo', Integer, ForeignKey('grupos_musculares.id'), nullable=False)

    grupo = relationship("GrupoMuscular", back_populates="exercicio")

    def __init__(self, id_grupo, nome):
        self.nome = nome
        self.id_grupo = id_grupo

#classe treino exercicio
class TreinoExercicio(base):
    __tablename__ = 'treinos_exercicios'
    id = Column('id', Integer, primary_key=True)
    id_treino = Column('id_treino', Integer, ForeignKey('treinos.id'), nullable=False)
    id_exercicio = Column('id_exercicio', Integer, ForeignKey('exercicios.id'), nullable=False)
    reps = Column('reps', Integer, nullable=False)
    peso = Column('peso', Double)
    data = Column('data', Date, default=date.today)

    treino = relationship("Treino", backref="treino_exercicios")
    exercicio = relationship("Exercicio", backref="treino_exercicios")

    def __init__(self, id_treino, id_exercicio, reps, peso):
        self.id_treino = id_treino
        self.id_exercicio = id_exercicio
        self.reps = reps
        self.peso = peso
        self.data = date.today()

base.metadata.create_all(bind=db)
#-----------final das classes-----------

#-----------começo das buscas-----------
app = FastAPI()
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

#---------------------------
class getId(BaseModel):
    busca: str

@app.post("/buscaCliente")
def obterCliente(request: getId, sessao: Session = Depends(get_session)):
    try:
        referencia = request.busca
        client = sessao.query(Cliente).filter(or_(Cliente.cpf == str(referencia), Cliente.email == str(referencia))).first()
        
        if not client:
            return {
                "id":    0, "nome":  "", "cpf":   "",
                "email": "", "senha": "", "nivel": 9,
                "idade": 0, "peso":  0, "altura":0, 
            }
        return {
            "id": client.id,
            "nome": client.nome,
            "cpf": client.cpf,
            "email": client.email,
            "senha": client.senha,
            "nivel": client.nivel,
            "idade": client.idade,
            "peso": client.peso,
            "altura": client.altura,
            
        }
    except Exception as e:
        return {"error": str(e)}

#---------------------------   
class GetReferencia(BaseModel):
    referencia: int
#---------------------------
@app.post("/buscaTreinos")
def obtemTreinos(ref: GetReferencia, sessao: Session = Depends(get_session)):
    try:
        referencia = ref.referencia
        treinos = sessao.query(Treino).filter(Treino.id_cliente == referencia).all()
        if not treinos:
            return []
        return [
            {
                "id": treino.id,
                "id_cliente": treino.id_cliente,
                "nome": treino.nome,
            }
            for treino in treinos
        ]
    except Exception as e:
        return {"error": str(e)}

class GetReferencia(BaseModel):
    referencia: int
#---------------------------
@app.post("/adicionarTreino/{id_cliente}/{nome}")
def adicionarTreinoCliente(id_cliente: int, nome: str, sessao: Session = Depends(get_session)):
    try:
        novo_treino = Treino(id_cliente=id_cliente, nome=nome)
        sessao.add(novo_treino)
        sessao.commit()
        return JSONResponse(
            status_code=200,
            content={"message": "treino adicionado com sucesso"}
        )
    except Exception as e:
        sessao.rollback()
        return JSONResponse(
            status_code=500,
            content={"error": f"Erro ao adicionar treino: {str(e)}"}
        )
#----------------------------
@app.delete("/deletarTreino/{treino_id}")
def deletarExercicioTreino(treino_id: int, sessao: Session = Depends(get_session)):
    try:
        treino = sessao.query(Treino).filter(
            TreinoExercicio.id_treino == treino_id,
        ).first()
        if not treino:
            return JSONResponse(status_code=404, content={"message": "series não encontradas"})
        
        exercicios = sessao.query(TreinoExercicio).filter(
            TreinoExercicio.id_treino == treino_id).all()
        
        for serie in exercicios:
            sessao.delete(serie)
        sessao.commit()

        sessao.delete(treino)
        sessao.commit()

        return {"message": "exercicio deletado com sucesso"}
    except Exception as e:
        sessao.rollback()
        return JSONResponse(status_code=500, content={"error": str(e)})
#----------------------------
@app.post("/buscaExercicios")
def obtemExercicios(ref: GetReferencia, sessao: Session = Depends(get_session)):
    try:
        referencia = ref.referencia
        consulta = sessao.query(Exercicio)\
            .join(TreinoExercicio, Exercicio.id == TreinoExercicio.id_exercicio)\
            .join(Treino, TreinoExercicio.id_treino == Treino.id)\
            .filter(Treino.id == referencia)\
            .group_by(TreinoExercicio.id_exercicio)
        exercicios = consulta.all()
        if not exercicios:
            return []
        return [
            {
                "id": exercicio.id,
                "nome": exercicio.nome,
                "id_grupo": exercicio.id_grupo
            }
            for exercicio in exercicios
        ]
    except Exception as e:
        return {"error":  str(e)}
#----------------------------
@app.get("/buscaExerciciosAll")
def busca_exercicios_all(sessao: Session = Depends(get_session)):
    try:
        exercicios = (
            sessao.query(
                Exercicio.id,
                Exercicio.nome,
                Exercicio.id_grupo,
                GrupoMuscular.nome.label('nome_grupo')
            )
            .join(GrupoMuscular, Exercicio.id_grupo == GrupoMuscular.id)
            .all()
        )
        resultado = [
            {
                "id": exercicio.id,
                "nome": exercicio.nome,
                "id_grupo": exercicio.id_grupo,
                "nome_grupo": exercicio.nome_grupo,
            }
            for exercicio in exercicios
        ]

        return resultado

    except Exception as e:
        sessao.rollback()
        return JSONResponse(
            status_code=500,
            content={"error": f"Erro ao buscar exercícios: {str(e)}"}
        )
#----------------------------
@app.delete("/deletarExercicio/{treino_id}/{exercicio_id}")
def deletarExercicioTreino(treino_id: int, exercicio_id: int, sessao: Session = Depends(get_session)):
    try:
        series = sessao.query(TreinoExercicio).filter(
            TreinoExercicio.id_treino == treino_id,
            TreinoExercicio.id_exercicio == exercicio_id
        ).all()
        if not series:
            return JSONResponse(status_code=404, content={"message": "series não encontradas"})
        for serie in series:
            sessao.delete(serie)

        sessao.commit()

        return {"message": "exercicio deletado com sucesso"}
    except Exception as e:
        sessao.rollback()
        return JSONResponse(status_code=500, content={"error": str(e)})
#----------------------------
@app.post("/adicionarExercicio/{nome}/{id_grupo}")
def adicionarExercicio(nome: str, id_grupo: int, sessao: Session = Depends(get_session)):
    try:
        novo_exercicio = Exercicio(id_grupo=id_grupo, nome=nome)
        sessao.add(novo_exercicio)
        sessao.commit()
        return JSONResponse(
            status_code=200,
            content={"message": "Exercício adicionado com sucesso"}
        )
    except Exception as e:
        sessao.rollback()
        return JSONResponse(
            status_code=500,
            content={"error": f"Erro ao adicionar exercício: {str(e)}"}
        )
#----------------------------
@app.get("/buscaEspecifico/{treino_id}/{exercicio_id}")
async def obtemExercicioEspecifico(treino_id: int, exercicio_id: int, sessao: Session = Depends(get_session)):
    try:
        query = sessao.query(TreinoExercicio).filter(
            TreinoExercicio.id_treino == treino_id,
            TreinoExercicio.id_exercicio == exercicio_id
        )\
        .filter(TreinoExercicio.reps != 0)\
        .order_by(TreinoExercicio.data)

        resultados = query.all()

        return JSONResponse(content=[{
            "id": r.id,
            "reps": r.reps,
            "peso": r.peso,
            "data": r.data.strftime("%Y-%m-%d")
        } for r in resultados])
    except Exception as e:
        return {"error": str(e)}
#----------------------------
@app.delete("/deletarSerie/{especifico_id}")
def deletarSerie(especifico_id: int, sessao: Session = Depends(get_session)):
    try:
        serie = sessao.query(TreinoExercicio).filter(TreinoExercicio.id == especifico_id).first()
        if not serie:
            return JSONResponse(status_code=404, content={"message": "Série não encontrada"})
        
        sessao.delete(serie)
        sessao.commit()
        return {"message": "Série deletada com sucesso"}
    except Exception as e:
        sessao.rollback()
        return JSONResponse(status_code=500, content={"error": str(e)})
#----------------------------
@app.post("/adicionarSerie/{treino_id}/{exercicio_id}/{reps}/{peso}")
def adicionarSerie(treino_id: int, exercicio_id: int, reps: int, peso: int, sessao: Session = Depends(get_session)):
    try:
        novaSerie = TreinoExercicio(treino_id, exercicio_id, reps, peso)
        sessao.add(novaSerie)
        sessao.commit()
        return {"message": "Série adicionada com sucesso"}
    except Exception as e:
        sessao.rollback()
        return JSONResponse(status_code=500, content={"error": str(e)})
#----------------------------
@app.get("/achaGrupo/{nome}")
def achar(nome: str, sessao: Session = Depends(get_session)):
    try:
        grupo = sessao.query(GrupoMuscular).filter(GrupoMuscular.nome == nome).first()
        if grupo is None:
            return JSONResponse(
                status_code=404, 
                content={"error": "Grupo muscular não encontrado"}
            )
        return grupo.id
    except Exception as e:
        sessao.rollback()
        return JSONResponse(
            status_code=500, 
            content={"error": str(e)}
        )
#----------------------------

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="localhost", port=57800)