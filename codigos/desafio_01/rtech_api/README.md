# RTech API

## Funcionalidades

A API oferece um CRUD completo para gerenciar solicitações:

- **Criar solicitação** - Registra uma nova solicitação no sistema
- **Listar solicitações** - Retorna todas as solicitações cadastradas
- **Buscar solicitação** - Obtém uma solicitação específica por ID
- **Atualizar solicitação** - Modifica os dados de uma solicitação existente
- **Deletar solicitação** - Remove uma solicitação do sistema

### Estrutura de uma Solicitação

Cada solicitação possui os seguintes campos:

- `id`: Identificador único gerado automaticamente (UUID)
- `tipo`: Tipo da solicitação
- `descricao`: Descrição detalhada da solicitação
- `status`: Status da solicitação (Pendente, Aprovada ou Rejeitada)

## Tecnologias Utilizadas

- **Python 3.8+**
- **FastAPI** - Framework web moderno e rápido
- **Uvicorn** - Servidor ASGI de alta performance
- **Pydantic** - Validação de dados

## Instalar as dependências

```bash
pip install -r requirements.txt
```

## Como Rodar o Programa

Execute o servidor com o comando:

```bash
uvicorn main:app --reload
```

## Documentação da API

Após iniciar o servidor, acesse a documentação interativa:

- **Swagger UI**: http://127.0.0.1:8000/docs
- **ReDoc**: http://127.0.0.1:8000/redoc

## Exemplo de Uso

```bash
# Criar uma solicitação
curl -X POST "http://127.0.0.1:8000/solicitacoes" \
  -H "Content-Type: application/json" \
  -d '{"tipo":"Férias","descricao":"Janeiro 2026","status":"Pendente"}'

# Listar todas as solicitações
curl -X GET "http://127.0.0.1:8000/solicitacoes"

# Buscar uma solicitação específica
curl -X GET "http://127.0.0.1:8000/solicitacoes/{id}"

# Atualizar uma solicitação
curl -X PUT "http://127.0.0.1:8000/solicitacoes/{id}" \
  -H "Content-Type: application/json" \
  -d '{"tipo":"Férias","descricao":"Fevereiro 2026","status":"Aprovada"}'

# Deletar uma solicitação
curl -X DELETE "http://127.0.0.1:8000/solicitacoes/{id}"
```

## Estrutura do Projeto

```
rtech_api/
├── main.py              # Código principal da API
├── requirements.txt     # Dependências do projeto
└── README.md           # Documentação
```