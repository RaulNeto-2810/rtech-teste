# Sistema de Gerenciamento de Solicitações
## Descrição

O sistema permite gerenciar solicitações através de um menu interativo no terminal, onde é possível:

- Cadastrar novas solicitações
- Listar todas as solicitações cadastradas
- Atualizar o status de solicitações existentes
- Excluir solicitações pelo ID

## Estrutura do Código

### Classe `Solicitacao`

```python
@dataclass
class Solicitacao:
    id: str
    tipo: str
    descricao: str
    status: str
```

Utiliza `dataclass` para representar uma solicitação com os campos:

- **id**: Identificador único da solicitação
- **tipo**: Categoria ou tipo da solicitação
- **descricao**: Descrição detalhada da solicitação
- **status**: Estado atual (ex: "Pendente", "Em andamento", "Concluído")

### Armazenamento

```python
db: Dict[str, Solicitacao] = {}
```

As solicitações são armazenadas em memória usando um dicionário, onde a chave é o ID da solicitação.


## Como Executar

1. Certifique-se de ter Python 3.7+ instalado
2. Execute o arquivo principal:

```bash
python main.py
```

## Exemplo de Uso

```
1 - Cadastrar nova solicitação
Escolha uma opção: 1

ID: SOL001
Tipo: Suporte Técnico
Descrição: Problema com impressora
Status (padrão: Pendente):
Solicitação cadastrada com sucesso.

2 - Listar todas as solicitações
Escolha uma opção: 2

Lista de Solicitações
- ID: SOL001 | Tipo: Suporte Técnico | Status: Pendente
  Descrição: Problema com impressora
```

## Estrutura do Projeto

```
desafio_02/
├── main.py
├── README.md
├── requirements.txt
├── .gitignore
├── docs/
│   └── ENUNCIADO.md
└── prints/
```