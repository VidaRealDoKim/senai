SELECT * FROM mensalidade;

## 1.Alunos Inadimplentes (mensalidades em aberto)

SELECT 
m.idmensalidade,
a.aluno_nome,
m.valor,
m.vencimento

From mensalidade m 
JOIN aluno a ON a.aluno_idaluno = a.idaluno
WHERE m.pago = false

## 2.Total arrecadado com mensalidades pagas

SELECT

## 3.Total pendente (mensalidades não pagas)

## 4.Relatório de status de pagamento por aluno

## 5.Média das mensalidades pagas
SELECT
	AVG (valor) AS media_valor_pago
FROM mensalidade
Where pago = TRUE;

## 6.Mensalidades por vencimento (ordenado)