from fastapi import FastAPI, Depends
from sqlalchemy import create_engine, Column, Integer, String, BigInteger, Double,or_
from sqlalchemy.orm import sessionmaker, declarative_base
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

class Cliente(base):
    __tablename__ = 'clientes'
    id = Column('id', Integer, primary_key=True, autoincrement=True)
    nome = Column('nome', String(100), nullable=False)  # Adicionado length
    cpf = Column('cpf', Integer, unique=True, nullable=False)
    email = Column('email', String(100), unique=True, nullable=False)
    senha = Column('senha', String(100), nullable=False)
    nivel = Column('nivel', Integer, nullable=False)  # Adicionado length
    idade = Column('idade', Integer)
    peso = Column('peso', Double)
    altura = Column('altura', Integer)  # Adicionado length
    

    def __init__(self, nome, cpf, email, idade, peso, altura, senha, nivel):  # Added default value
        self.nome = nome
        self.cpf = cpf
        self.email = email
        self.senha = senha
        self.nivel = nivel
        self.idade = idade
        self.peso = peso
        self.altura = altura
        

base.metadata.create_all(bind=db)


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
        client = sessao.query(Cliente).filter(Cliente.cpf == str(referencia)).first()  # Ensure types match
        
        if not client:
            return {
                "id":    False, "nome":  False, "cpf":   False,
                "email": False, "senha": False, "nivel": False,
                "idade": False, "peso":  False, "altura":False, 
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
        
if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="localhost", port=57800)
