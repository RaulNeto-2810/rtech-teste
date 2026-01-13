# Desafio 4:

Implemente uma API REST (em Java + Spring Boot ou Kotlin + Ktor/Spring) que realize operações de CRUD para uma entidade Solicitacao.

## Campos obrigatórios:

- id (Long ou UUID)
- tipo (String – ex.: “Férias”, “Reembolso”, “Treinamento”)
- descricao (String)
- status (String – “Pendente”, “Aprovada”, “Rejeitada”)
- dataCriacao (LocalDateTime)

## Endpoints esperados:

- Metado: POST; Endpoint: /solicitacoes; Descrição: Cadastra nova solicitação.
- Metado: GET; Endpoint: /solicitacoes; Descrição: Lista todas as solicitações.
- Metado: GET; Endpoint: /solicitacoes/{id}; Descrição: Busca solicitação pelo ID.
- Metado: PUT; Endpoint: /solicitacoes/{id}; Descrição: Atualiza status e descrição.
- Metado: DELETE; Endpoint: /solicitacoes/{id}; Descrição: Remove solicitação existente.

## Requisitos mínimos

- Implementar API REST funcional.
- Utilizar boas práticas de código (nomes claros, separação de responsabilidades).
- Retornar status HTTP adequados (200, 201, 404, 400, etc.).
- Persistir dados em memória (lista, mapa) ou banco local (H2, SQLite).