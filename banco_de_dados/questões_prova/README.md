# 3 - QUESTÕES DA PROVA

## 3.1 - JOIN e ORDER BY (2,0 pontos)

Crie uma consulta que retorne:

- Nome do funcionário  
- Matrícula  
- Departamento  
- Valor solicitado  
- Status da solicitação  
- Data da solicitação  

### Requisitos

- Incluir **APENAS** solicitações com status **`APROVADO`**
- Ordenar por departamento (ordem alfabética) e depois por valor solicitado (do maior para o menor)
- Incluir somente solicitações feitas nos últimos **6 meses**

---

## 3.2 - GROUP BY e HAVING (2,0 pontos)

Crie uma consulta que mostre um relatório mensal de solicitações, contendo:

- Ano e mês da solicitação  
- Quantidade total de solicitações  
- Valor total solicitado  
- Valor médio das solicitações  
- Quantidade de solicitações aprovadas  

### Requisitos

- Agrupar por ano e mês
- Mostrar **APENAS** os meses que tiveram mais de **10 solicitações**
- Ordenar do mês mais recente para o mais antigo
- Formatar o ano/mês como **`YYYY-MM`**

---

## 3.3 - TRIGGER (2,0 pontos)

Crie um **TRIGGER** que:

- Seja acionado **APÓS** a inserção de um novo registro na tabela `pagamentos`
- Atualize automaticamente o status da solicitação correspondente para **`PAGO`**
- Registre na tabela `log_auditoria` as informações da operação

---

## 3.4 - STORED PROCEDURE (2,0 pontos)

Crie uma **STORED PROCEDURE** chamada `sp_cancelar_solicitacao` que:

- Receba o **ID da solicitação** e o **motivo**
- Verifique se a solicitação pode ser cancelada (não pode se já foi **PAGO**)
- Atualize o status para **`CANCELADO`**
- Registre a operação no log
- Retorne uma mensagem de sucesso ou erro

---

## 3.5 - SUBCONSULTA e WINDOW FUNCTION (2,0 pontos)

Crie uma consulta que identifique os funcionários **"top gastadores"**, retornando:

- Nome do funcionário  
- Departamento  
- Total gasto  
- Quantidade de solicitações aprovadas  
- Ranking dentro do departamento  
- Percentual do total do departamento  

### Requisitos

- Considerar apenas solicitações **APROVADAS** com pagamentos
- Retornar o **TOP 3** de cada departamento
- Percentual com **2 casas decimais**