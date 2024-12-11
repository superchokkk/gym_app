from fastapi import FastAPI, Depends
from sqlalchemy import create_engine, Column, Integer, String, ForeignKey, Double,or_
from sqlalchemy.orm import sessionmaker, declarative_base, relationship
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel

# Database configuration
db = create_engine("mysql+mysqlconnector://root:@localhost:3306/testeacademia", echo=True)
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
class getId(BaseModel):
    busca: str

@app.post("/buscaCliente")
def obterCliente(request: getId, sessao: Session = Depends(get_session)):
    try:
        referencia = request.busca
        client = sessao.query(Cliente).filter(or_(Cliente.cpf == str(referencia), Cliente.email == str(referencia))).first()  # Ensure types match
        
        if not client:
            return {
                "id":    0, "nome":  "", "cpf":   0,
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
    
@app.post("/buscaTreinos")
def obtemTreinos(referencia, sessao: Session = Depends(get_session)):
    try:
        treinos = sessao.query(Treino).filter(Treino.id_cliente == referencia).all()
        
        if not treinos:
            return {"message": "Nenhum treino encontrado para o cliente."}

            
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

        
if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="localhost", port=57800)
