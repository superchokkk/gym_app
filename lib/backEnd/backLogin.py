from fastapi import FastAPI, Depends
from flask import session, jsonify
from sqlalchemy import create_engine, Column, Integer, String, ForeignKey, Double, or_, Date, select, func
from sqlalchemy.orm import sessionmaker, declarative_base, relationship, aliased
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from fastapi.responses import JSONResponse
from datetime import date
from confg import DATABASE_URL;
from datetime import datetime

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
    cpf = Column('cpf', String(11), unique=True, nullable=False)
    email = Column('email', String(100), unique=True, nullable=False)
    senha = Column('senha', String(100), nullable=False)
    nivel = Column('nivel', Integer, nullable=False)
    idade = Column('idade', Integer)
    peso = Column('peso', Double)
    altura = Column('altura', Integer)
    data_pgto = Column('data_pgto', Date, default=datetime.now)

    treinos = relationship("Treino", back_populates="cliente")

    def __init__(self, nome, cpf, email, idade, peso, altura, senha, nivel, data_pgto=None):
        self.nome = nome
        self.cpf = cpf
        self.email = email
        self.senha = senha
        self.nivel = nivel
        self.idade = idade
        self.peso = peso
        self.altura = altura
        self.data_pgto = data_pgto or datetime.now()

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
class getId2(BaseModel):
    busca: int

@app.post("/buscaCliente")
def obterCliente(request: getId, sessao: Session = Depends(get_session)):
    try:
        referencia = request.busca
        client = sessao.query(Cliente).filter(or_(Cliente.cpf == str(referencia), Cliente.email == str(referencia))).first()
        
        if not client:
            return {
                "id": 0, "nome": "", "cpf": "",
                "email": "", "senha": "", "nivel": 9,
                "idade": 0, "peso": 0, "altura": 0,
                "data": ""
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
            "data": client.data_pgto.strftime("%d/%m/%Y") if client.data_pgto else ""
        }
    except Exception as e:
        return {"error": str(e)}

#---------------------------   
@app.post("/buscaClienteId")
def obterClienteId(request: getId2, sessao: Session = Depends(get_session)):
    try:
        referencia = request.busca
        client = sessao.query(Cliente).filter(Cliente.id == referencia).first()
        
        if not client:
            return {
                "id": 0, "nome": "", "cpf": "",
                "email": "", "senha": "", "nivel": 9,
                "idade": 0, "peso": 0, "altura": 0,
                "data": ""
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
            "data": client.data_pgto.strftime("%d/%m/%Y") if client.data_pgto else ""
        }
    except Exception as e:
        return {"error": str(e)}

#---------------------------
@app.delete("/deletarCliente/{cliente_id}")
def deletarCliente(cliente_id: int, sessao: Session = Depends(get_session)):
    try:
        treinos = sessao.query(Treino).filter(Treino.id_cliente == cliente_id).all()
        
        # First delete all related TreinoExercicio records
        for treino in treinos:
            sessao.query(TreinoExercicio).filter(
                TreinoExercicio.id_treino == treino.id
            ).delete()
            sessao.delete(treino)
            
        # Then delete the client
        cliente = sessao.query(Cliente).filter(Cliente.id == cliente_id).first()
        if cliente:
            sessao.delete(cliente)
            sessao.commit()
            return JSONResponse(
                status_code=200,
                content={"message": "Cliente deletado com sucesso"}
            )
        else:
            return JSONResponse(
                status_code=404,
                content={"message": "Cliente não encontrado"}
            )
        
    except Exception as e:
        sessao.rollback()
        print(f"Erro ao deletar cliente: {str(e)}")
        return JSONResponse(
            status_code=500,
            content={"error": f"Erro ao deletar cliente: {str(e)}"}
        )
#--------------------------- 
class NovoCliente(BaseModel):
    nome: str
    cpf: str
    email: str
    senha: str
    nivel: int
    idade: int
    peso: float
    altura: float

@app.post("/adicionarCliente")
def adicionar_cliente(cliente: dict, sessao: Session = Depends(get_session)):
    try:
        # Check if CPF already exists
        existing_cliente = sessao.query(Cliente).filter(
            Cliente.cpf == cliente['cpf']
        ).first()
        
        if existing_cliente:
            return JSONResponse(
                status_code=400,
                content={"error": "CPF já cadastrado"}
            )
            
        novo_cliente = Cliente(
            nome=cliente['nome'],
            cpf=cliente['cpf'],  # Keep as string
            email=cliente['email'],
            senha=cliente['senha'],
            nivel=cliente['nivel'],
            idade=cliente['idade'],
            peso=cliente['peso'],
            altura=cliente['altura'],
            data_pgto=datetime.now()
        )
        
        sessao.add(novo_cliente)
        sessao.commit()
        
        return JSONResponse(
            status_code=200,
            content={"message": "Cliente adicionado com sucesso"}
        )
        
    except Exception as e:
        sessao.rollback()
        print(f"Erro ao adicionar cliente: {str(e)}")
        return JSONResponse(
            status_code=500,
            content={"error": f"Erro ao adicionar cliente: {str(e)}"}
        )
#--------------------------- 
@app.get("/buscaFuncionarios")
def buscaFuncionarios(sessao: Session = Depends(get_session)):
    try:
        funcionarios = sessao.query(Cliente).filter(Cliente.nivel == 2).all()
        
        if not funcionarios:
            return []
            
        return [
            {
                "id": func.id,
                "nome": func.nome,
                "email": func.email,
                "idade": func.idade,
                "nivel": func.nivel,
            }
            for func in funcionarios
        ]

    except Exception as e:
        sessao.rollback()
        return JSONResponse(
            status_code=500,
            content={"error": f"Erro ao buscar funcionários: {str(e)}"}
        )
#----------------------------
@app.get("/buscaClientes")
def buscaClientes(sessao: Session = Depends(get_session)):
    try:
        funcionarios = sessao.query(Cliente).filter(Cliente.nivel == 3).all()
        
        if not funcionarios:
            return []
            
        return [
            {
                "id": func.id,
                "nome": func.nome,
                "cpf": func.cpf,
                "email": func.email,
                "nivel": func.nivel,
                "idade": func.idade,
                "peso": func.peso,
                "altura": func.altura,
                "data": func.data_pgto.strftime("%d/%m/%Y") if func.data_pgto else ""
            }
            for func in funcionarios
        ]

    except Exception as e:
        sessao.rollback()
        return JSONResponse(
            status_code=500,
            content={"error": f"Erro ao buscar funcionários: {str(e)}"}
        )
#----------------------------
@app.post("/atualizarPgto/{cliente_id}/{flag}")
def atualizarStatus(cliente_id: int, flag: int, sessao: Session = Depends(get_session)):
    try:
        cliente = sessao.query(Cliente).filter(Cliente.id == cliente_id).first()
        
        if not cliente:
            return JSONResponse(
                status_code=404,
                content={"message": "Cliente não encontrado"}
            )
            
        
        now = datetime.now()
        
        if flag == 1: 
            cliente.data_pgto = now
        elif flag == 2:
            if now.month == 1:
                cliente.data_pgto = datetime(now.year - 1, 12, 1)
            else:
                cliente.data_pgto = datetime(now.year, now.month - 1, 1)
        elif flag == 3:
            year = now.year
            month = now.month - 2
            if month <= 0:
                year = now.year - 1
                month = 12 + month
            cliente.data_pgto = datetime(year, month, 1)

        else:
            return JSONResponse(
                status_code=400,
                content={"message": "Status inválido"},
            ) 
        sessao.commit()
        
        return JSONResponse(
            status_code=200,
            content={"message": "Status atualizado com sucesso"}
        )
        
    except Exception as e:
        sessao.rollback()
        print(f"Erro: {str(e)}")
        return JSONResponse(
            status_code=500,
            content={"error": f"Erro ao atualizar status: {str(e)}"}
        )
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