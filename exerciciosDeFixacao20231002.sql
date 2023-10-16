CREATE TABLE nomes (
    nome VARCHAR(50)
);

INSERT INTO nomes (nome)
VALUES ('Roberta'), ('Roberto'), ('Maria Clara'), ('João');

SELECT UPPER(nome) FROM nomes;
SELECT nome, LENGTH(nome) AS tamanho FROM nomes;
SELECT 
    CASE 
        WHEN nome LIKE '%João%' OR nome LIKE '%Roberto%' THEN CONCAT('Sr. ', nome)
        ELSE CONCAT('Sra. ', nome)
    END AS nome_com_tratamento
FROM nomes;
