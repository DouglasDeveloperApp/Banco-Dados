
CREATE SEQUENCE SEQ_ALUNO1
START WITH 60
--Valor Inicial
INCREMENT BY 2
--Qtde a Incrementar
MINVALUE 60
--Valor Minimo
MAXVALUE 100
--Valor Maximo
NOCACHE
--nao guarda em cache faixa de valores -- 20
NOCYCLE;
--
--
INSERT INTO TAluno (Cod_Aluno, Nome)
VALUES (Seq_Aluno1.NEXTVAL,'MASTER TRAINING 2');
--Proximo Value

SELECT * FROM TALUNO;
COMMIT;

SELECT * FROM USER_SEQUENCES;

--Valor Atual
SELECT SEQ_ALUNO1.CURRVAL FROM DUAL;

ALTER SEQUENCE SEQ_ALUNO1 MAXVALUE  500;

--Alterar Valor da Sequencia
DROP SEQUENCE SEQ_ALUNO1;
CREATE SEQUENCE SEQ_ALUNO1 START WITH 80;

--------------------------------------------------------------------------------

--Indices Secundario
SELECT NOME FROM TALUNO
WHERE NOME LIKE '%A%';    --F9

CREATE INDEX IND_TALUNO_NOME ON TALUNO(NOME);

SELECT nome FROM TALUNO
WHERE NOME LIKE '%MA%';   --F9

--
CREATE INDEX IND_TALU_NOMECIDADE
ON TALUNO(NOME, CIDADE);

SELECT nome,cidade FROM TALUNO
WHERE NOME LIKE '%A%' AND CIDADE LIKE '%A%';

--Consultar os indeces das tabelas
SELECT * FROM USER_INDEXES;

DROP INDEX IND_TALU_NOMECIDADE;


--Sinonimos
-- Diminuir o tamanho do nome da tabela - da um apelido para um objeto/tabela
CREATE SYNONYM ALU FOR TALUNO;


SELECT * FROM ALU;

