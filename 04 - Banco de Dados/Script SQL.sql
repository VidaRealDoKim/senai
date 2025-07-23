## 1. Alunos inadimplentes (mensalidades em aberto) com valor total pendente
-- Seleciona os alunos que possuem mensalidades não pagas e soma o valor total dessas mensalidades em aberto
SELECT 
  a.idaluno, 
  a.aluno_nome,
  SUM(m.valor) AS total_pendente
FROM aluno a
JOIN mensalidade m ON a.idaluno = m.aluno_idaluno
WHERE m.pago = FALSE
GROUP BY a.idaluno, a.aluno_nome
ORDER BY total_pendente DESC;


## 2. Total arrecadado com mensalidades pagas

-- Soma o valor de todas as mensalidades que foram pagas
SELECT SUM(valor) AS total_arrecadado
FROM mensalidade
WHERE pago = TRUE;

## 3. Total pendente (mensalidades não pagas)

-- Soma o valor de todas as mensalidades que ainda não foram pagas
SELECT SUM(valor) AS total_pendente
FROM mensalidade
WHERE pago = FALSE;

## 4. Relatório de status de pagamento por aluno
-- Para cada aluno, mostra: total pago, total pendente, quantidade de mensalidades abertas, quantidade de mensalidades pagas
SELECT 
  a.idaluno,
  a.aluno_nome,
  SUM(CASE WHEN m.pago = TRUE THEN m.valor ELSE 0 END) AS total_pago,
  SUM(CASE WHEN m.pago = FALSE THEN m.valor ELSE 0 END) AS total_pendente,
  COUNT(CASE WHEN m.pago = FALSE THEN 1 END) AS mensalidades_abertas,
  COUNT(CASE WHEN m.pago = TRUE THEN 1 END) AS mensalidades_pagas
FROM aluno a
LEFT JOIN mensalidade m ON a.idaluno = m.aluno_idaluno
GROUP BY a.idaluno, a.aluno_nome
ORDER BY a.idaluno;

## 5. Média das mensalidades pagas

-- Calcula a média do valor das mensalidades que foram pagas
SELECT 
  CAST(AVG(m.valor) AS DECIMAL(10,2)) AS media_mensalidades_pagas
FROM mensalidade m
WHERE m.pago = TRUE;


## 6. 	
-- Lista todas as mensalidades com dados do aluno
SELECT 
  a.idaluno,
  a.aluno_nome,
  m.valor,
  m.vencimento,
  CASE -- 0 e 1 Pago e não pago
    WHEN m.pago = TRUE THEN 'PAGO'
    ELSE 'ATRASADO'
  END AS status_pagamento
FROM mensalidade m
JOIN aluno a ON m.aluno_idaluno = a.idaluno
ORDER BY m.vencimento ASC;


## 7. atualização da tabela mensalidade

-- Deleta tabela antiga
TRUNCATE TABLE mensalidade;

USE escola;

-- Atualizar mensalidades com valores, status e vencimentos variados
UPDATE mensalidade SET valor = 465.00, pago = FALSE, vencimento = '2025-07-01' WHERE aluno_idaluno = 1 AND vencimento = '2025-07-05';
UPDATE mensalidade SET valor = 470.00, pago = TRUE,  vencimento = '2025-07-02' WHERE aluno_idaluno = 2 AND vencimento = '2025-07-05';
UPDATE mensalidade SET valor = 475.00, pago = FALSE, vencimento = '2025-07-03' WHERE aluno_idaluno = 3 AND vencimento = '2025-07-05';
UPDATE mensalidade SET valor = 480.00, pago = TRUE,  vencimento = '2025-07-04' WHERE aluno_idaluno = 4 AND vencimento = '2025-07-05';
UPDATE mensalidade SET valor = 455.00, pago = FALSE, vencimento = '2025-07-06' WHERE aluno_idaluno = 5 AND vencimento = '2025-07-05';
UPDATE mensalidade SET valor = 460.00, pago = TRUE,  vencimento = '2025-07-07' WHERE aluno_idaluno = 6 AND vencimento = '2025-07-05';
UPDATE mensalidade SET valor = 470.00, pago = FALSE, vencimento = '2025-07-08' WHERE aluno_idaluno = 7 AND vencimento = '2025-07-05';
UPDATE mensalidade SET valor = 475.00, pago = TRUE,  vencimento = '2025-07-09' WHERE aluno_idaluno = 8 AND vencimento = '2025-07-05';
UPDATE mensalidade SET valor = 485.00, pago = FALSE, vencimento = '2025-07-10' WHERE aluno_idaluno = 9 AND vencimento = '2025-07-05';
UPDATE mensalidade SET valor = 495.00, pago = TRUE,  vencimento = '2025-07-11' WHERE aluno_idaluno = 10 AND vencimento = '2025-07-05';
UPDATE mensalidade SET valor = 465.00, pago = FALSE, vencimento = '2025-07-12' WHERE aluno_idaluno = 11 AND vencimento = '2025-07-05';
UPDATE mensalidade SET valor = 470.00, pago = TRUE,  vencimento = '2025-07-13' WHERE aluno_idaluno = 12 AND vencimento = '2025-07-05';
UPDATE mensalidade SET valor = 480.00, pago = FALSE, vencimento = '2025-07-14' WHERE aluno_idaluno = 13 AND vencimento = '2025-07-05';
UPDATE mensalidade SET valor = 455.00, pago = TRUE,  vencimento = '2025-07-15' WHERE aluno_idaluno = 14 AND vencimento = '2025-07-05';
UPDATE mensalidade SET valor = 460.00, pago = FALSE, vencimento = '2025-07-16' WHERE aluno_idaluno = 15 AND vencimento = '2025-07-05';
UPDATE mensalidade SET valor = 475.00, pago = TRUE,  vencimento = '2025-07-17' WHERE aluno_idaluno = 16 AND vencimento = '2025-07-05';
UPDATE mensalidade SET valor = 485.00, pago = FALSE, vencimento = '2025-07-18' WHERE aluno_idaluno = 17 AND vencimento = '2025-07-05';
UPDATE mensalidade SET valor = 495.00, pago = TRUE,  vencimento = '2025-07-19' WHERE aluno_idaluno = 18 AND vencimento = '2025-07-05';
UPDATE mensalidade SET valor = 465.00, pago = FALSE, vencimento = '2025-07-20' WHERE aluno_idaluno = 19 AND vencimento = '2025-07-05';
UPDATE mensalidade SET valor = 470.00, pago = TRUE,  vencimento = '2025-07-21' WHERE aluno_idaluno = 20 AND vencimento = '2025-07-05';


### mes 09

INSERT INTO mensalidade (aluno_idaluno, valor, vencimento, pago) VALUES
(1, 460.00, '2025-09-05', FALSE),
(2, 470.00, '2025-09-10', FALSE),
(3, 480.00, '2025-09-15', TRUE),
(4, 490.00, '2025-09-20', FALSE),
(5, 455.00, '2025-09-25', TRUE),
(6, 475.00, '2025-09-05', FALSE),
(7, 465.00, '2025-09-10', TRUE),
(8, 485.00, '2025-09-15', FALSE),
(9, 495.00, '2025-09-20', TRUE),
(10, 470.00, '2025-09-25', FALSE),
(11, 480.00, '2025-09-05', TRUE),
(12, 460.00, '2025-09-10', FALSE),
(13, 470.00, '2025-09-15', TRUE),
(14, 490.00, '2025-09-20', TRUE),
(15, 455.00, '2025-09-25', FALSE),
(16, 465.00, '2025-09-05', TRUE),
(17, 485.00, '2025-09-10', FALSE),
(18, 495.00, '2025-09-15', TRUE),
(19, 475.00, '2025-09-20', TRUE),
(20, 460.00, '2025-09-25', FALSE);



