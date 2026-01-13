-- =========================================================
-- PROVA POSTGRESQL - Sistema de Auxílio Transporte
-- Autor: Raul Neto
-- =========================================================

-- limpeza (para rodar quantas vezes quiser)
DROP TABLE IF EXISTS log_auditoria CASCADE;
DROP TABLE IF EXISTS pagamentos CASCADE;
DROP TABLE IF EXISTS solicitacoes_auxilio CASCADE;
DROP TABLE IF EXISTS funcionarios CASCADE;

-- tabela funcionarios
CREATE TABLE funcionarios (
    id            BIGSERIAL PRIMARY KEY,
    matricula     VARCHAR(20) NOT NULL UNIQUE,
    nome          VARCHAR(120) NOT NULL,
    departamento  VARCHAR(80) NOT NULL,
    data_admissao DATE NOT NULL DEFAULT CURRENT_DATE
);

-- tabela solicitacoes de auxilio
CREATE TABLE solicitacoes_auxilio (
    id               BIGSERIAL PRIMARY KEY,
    id_funcionario   BIGINT NOT NULL REFERENCES funcionarios(id) ON DELETE RESTRICT,
    valor_solicitado NUMERIC(12,2) NOT NULL CHECK (valor_solicitado > 0),
    status           VARCHAR(20) NOT NULL CHECK (status IN ('PENDENTE','APROVADO','REJEITADO','PAGO','CANCELADO')),
    data_solicitacao TIMESTAMP NOT NULL DEFAULT NOW()
);

-- tabela pagamentos
CREATE TABLE pagamentos (
    id              BIGSERIAL PRIMARY KEY,
    id_solicitacao  BIGINT NOT NULL UNIQUE REFERENCES solicitacoes_auxilio(id) ON DELETE RESTRICT,
    valor_pago      NUMERIC(12,2) NOT NULL CHECK (valor_pago > 0),
    data_pagamento  TIMESTAMP NOT NULL DEFAULT NOW()
);

-- tabela log de auditoria
CREATE TABLE log_auditoria (
    id           BIGSERIAL PRIMARY KEY,
    tabela       VARCHAR(60) NOT NULL,
    operacao     VARCHAR(20) NOT NULL, -- INSERT/UPDATE/DELETE
    registro_id  BIGINT,
    detalhes     TEXT,
    data_evento  TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Índices úteis
-- CREATE INDEX idx_solicitacoes_data ON solicitacoes_auxilio (data_solicitacao);
-- CREATE INDEX idx_solicitacoes_status ON solicitacoes_auxilio (status);
-- CREATE INDEX idx_funcionarios_depto ON funcionarios (departamento);

