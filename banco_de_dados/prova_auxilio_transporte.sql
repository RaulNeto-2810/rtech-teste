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

-- Índices
-- CREATE INDEX idx_solicitacoes_data ON solicitacoes_auxilio (data_solicitacao);
-- CREATE INDEX idx_solicitacoes_status ON solicitacoes_auxilio (status);
-- CREATE INDEX idx_funcionarios_depto ON funcionarios (departamento);

-- 2) INSERÇÃO DE DADOS
INSERT INTO funcionarios (matricula, nome, departamento, data_admissao) VALUES
('MAT-0001','Ana Souza','Financeiro', CURRENT_DATE - INTERVAL '900 days'),
('MAT-0002','Bruno Lima','Financeiro', CURRENT_DATE - INTERVAL '850 days'),
('MAT-0003','Carla Mendes','Financeiro', CURRENT_DATE - INTERVAL '800 days'),
('MAT-0004','Diego Rocha','RH', CURRENT_DATE - INTERVAL '700 days'),
('MAT-0005','Eduarda Alves','RH', CURRENT_DATE - INTERVAL '650 days'),
('MAT-0006','Felipe Costa','RH', CURRENT_DATE - INTERVAL '620 days'),
('MAT-0007','Gustavo Silva','TI', CURRENT_DATE - INTERVAL '1000 days'),
('MAT-0008','Helena Pereira','TI', CURRENT_DATE - INTERVAL '950 days'),
('MAT-0009','Igor Santos','TI', CURRENT_DATE - INTERVAL '900 days'),
('MAT-0010','Julia Freitas','TI', CURRENT_DATE - INTERVAL '880 days'),
('MAT-0011','Kaique Moraes','Operações', CURRENT_DATE - INTERVAL '760 days'),
('MAT-0012','Larissa Campos','Operações', CURRENT_DATE - INTERVAL '740 days'),
('MAT-0013','Marcos Oliveira','Operações', CURRENT_DATE - INTERVAL '720 days'),
('MAT-0014','Nathalia Ribeiro','Operações', CURRENT_DATE - INTERVAL '700 days'),
('MAT-0015','Otavio Martins','Comercial', CURRENT_DATE - INTERVAL '680 days'),
('MAT-0016','Patricia Barros','Comercial', CURRENT_DATE - INTERVAL '660 days'),
('MAT-0017','Rafael Araujo','Comercial', CURRENT_DATE - INTERVAL '640 days'),
('MAT-0018','Sara Nunes','Comercial', CURRENT_DATE - INTERVAL '620 days'),
('MAT-0019','Tiago Fernandes','Juridico', CURRENT_DATE - INTERVAL '600 days'),
('MAT-0020','Vanessa Teixeira','Juridico', CURRENT_DATE - INTERVAL '580 days');

INSERT INTO solicitacoes_auxilio (id_funcionario, valor_solicitado, status, data_solicitacao) VALUES
-- Mês atual (12)
(1,  180.00,'APROVADO', NOW() - INTERVAL '5 days'),
(2,  220.00,'APROVADO', NOW() - INTERVAL '6 days'),
(3,  150.00,'PENDENTE', NOW() - INTERVAL '7 days'),
(4,  310.00,'APROVADO', NOW() - INTERVAL '8 days'),
(5,  90.00 ,'REJEITADO',NOW() - INTERVAL '9 days'),
(6,  400.00,'APROVADO', NOW() - INTERVAL '10 days'),
(7,  275.00,'APROVADO', NOW() - INTERVAL '11 days'),
(8,  130.00,'PENDENTE', NOW() - INTERVAL '12 days'),
(9,  510.00,'APROVADO', NOW() - INTERVAL '13 days'),
(10, 210.00,'APROVADO', NOW() - INTERVAL '14 days'),
(11, 195.00,'APROVADO', NOW() - INTERVAL '15 days'),
(12, 260.00,'REJEITADO',NOW() - INTERVAL '16 days'),

-- 1 mês atrás (12)
(13, 140.00,'APROVADO', NOW() - INTERVAL '35 days'),
(14, 200.00,'APROVADO', NOW() - INTERVAL '36 days'),
(15, 180.00,'APROVADO', NOW() - INTERVAL '37 days'),
(16, 330.00,'PENDENTE', NOW() - INTERVAL '38 days'),
(17, 120.00,'APROVADO', NOW() - INTERVAL '39 days'),
(18, 410.00,'APROVADO', NOW() - INTERVAL '40 days'),
(19, 90.00 ,'REJEITADO',NOW() - INTERVAL '41 days'),
(20, 520.00,'APROVADO', NOW() - INTERVAL '42 days'),
(1,  210.00,'APROVADO', NOW() - INTERVAL '43 days'),
(2,  190.00,'PENDENTE', NOW() - INTERVAL '44 days'),
(3,  260.00,'APROVADO', NOW() - INTERVAL '45 days'),
(4,  300.00,'APROVADO', NOW() - INTERVAL '46 days'),

-- 2 meses atrás (12)
(5,  110.00,'APROVADO', NOW() - INTERVAL '65 days'),
(6,  240.00,'APROVADO', NOW() - INTERVAL '66 days'),
(7,  360.00,'APROVADO', NOW() - INTERVAL '67 days'),
(8,  80.00 ,'REJEITADO',NOW() - INTERVAL '68 days'),
(9,  200.00,'PENDENTE', NOW() - INTERVAL '69 days'),
(10, 450.00,'APROVADO', NOW() - INTERVAL '70 days'),
(11, 125.00,'APROVADO', NOW() - INTERVAL '71 days'),
(12, 175.00,'APROVADO', NOW() - INTERVAL '72 days'),
(13, 205.00,'APROVADO', NOW() - INTERVAL '73 days'),
(14, 260.00,'APROVADO', NOW() - INTERVAL '74 days'),
(15, 310.00,'PENDENTE', NOW() - INTERVAL '75 days'),
(16, 510.00,'APROVADO', NOW() - INTERVAL '76 days');

-- 3.1) JOIN e ORDER BY
SELECT
    f.nome,
    f.matricula,
    f.departamento,
    s.valor_solicitado,
    s.status,
    s.data_solicitacao
FROM solicitacoes_auxilio s
JOIN funcionarios f ON f.id = s.id_funcionario
WHERE s.status = 'APROVADO'
    AND s.data_solicitacao >= (NOW() - INTERVAL '6 months')
ORDER BY f.departamento ASC, s.valor_solicitado DESC;

-- 3.2) GROUP BY e HAVING
SELECT
    TO_CHAR(DATE_TRUNC('month', s.data_solicitacao), 'YYYY-MM') AS ano_mes,
    COUNT(*) AS qtd_solicitacoes,
    SUM(s.valor_solicitado) AS valor_total_solicitado,
    ROUND(AVG(s.valor_solicitado), 2) AS valor_medio_solicitacoes,
    SUM(CASE WHEN s.status = 'APROVADO' THEN 1 ELSE 0 END) AS qtd_aprovadas
FROM solicitacoes_auxilio s
GROUP BY DATE_TRUNC('month', s.data_solicitacao)
HAVING COUNT(*) > 10
ORDER BY DATE_TRUNC('month', s.data_solicitacao) DESC;

-- 3.3) TRIGGER: ao inserir pagamento -> status PAGO + log
CREATE OR REPLACE FUNCTION fn_pagamento_pos_insert()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_old_status TEXT;
BEGIN
    SELECT status INTO v_old_status
    FROM solicitacoes_auxilio
    WHERE id = NEW.id_solicitacao;

    UPDATE solicitacoes_auxilio
    SET status = 'PAGO'
    WHERE id = NEW.id_solicitacao;

    INSERT INTO log_auditoria (tabela, operacao, registro_id, detalhes)
    VALUES (
    'pagamentos',
    'INSERT',
    NEW.id,
    'Pagamento inserido para solicitacao_id=' || NEW.id_solicitacao ||
    '; status_anterior=' || COALESCE(v_old_status, 'NULL') ||
    '; novo_status=PAGO; valor_pago=' || NEW.valor_pago
    );

    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_pagamento_pos_insert ON pagamentos;

CREATE TRIGGER trg_pagamento_pos_insert
AFTER INSERT ON pagamentos
FOR EACH ROW
EXECUTE FUNCTION fn_pagamento_pos_insert();

-- Inserir 20 pagamentos 
INSERT INTO pagamentos (id_solicitacao, valor_pago, data_pagamento)
SELECT s.id, s.valor_solicitado, NOW()
FROM solicitacoes_auxilio s
WHERE s.status = 'APROVADO'
ORDER BY s.data_solicitacao DESC
LIMIT 20;

-- 3.4) STORED PROCEDURE 
CREATE OR REPLACE FUNCTION sp_cancelar_solicitacao(p_id_solicitacao BIGINT, p_motivo TEXT)
RETURNS TEXT
LANGUAGE plpgsql
AS $$
DECLARE
    v_status_atual TEXT;
BEGIN
    SELECT status INTO v_status_atual
    FROM solicitacoes_auxilio
    WHERE id = p_id_solicitacao;

    IF v_status_atual IS NULL THEN
        RETURN 'ERRO: Solicitação não encontrada (id=' || p_id_solicitacao || ').';
    END IF;

    IF v_status_atual = 'PAGO' THEN
        RETURN 'ERRO: Não é permitido cancelar uma solicitação já PAGA (id=' || p_id_solicitacao || ').';
    END IF;

    UPDATE solicitacoes_auxilio
    SET status = 'CANCELADO'
    WHERE id = p_id_solicitacao;

    INSERT INTO log_auditoria (tabela, operacao, registro_id, detalhes)
    VALUES (
    'solicitacoes_auxilio',
    'UPDATE',
    p_id_solicitacao,
    'Solicitação cancelada. Motivo: ' || COALESCE(p_motivo, '(sem motivo)')
    );

    RETURN 'OK: Solicitação ' || p_id_solicitacao || ' cancelada com sucesso.';
END;
$$;
