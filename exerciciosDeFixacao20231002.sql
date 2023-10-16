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

CREATE TABLE produtos (
    produto VARCHAR(50),
    preco DECIMAL(10, 2),
    quantidade INT
);

INSERT INTO produtos (produto, preco, quantidade)
VALUES ('Produto A', 10.99, 5), ('Produto B', 15.50, 0), ('Produto C', 25.75, -2);

SELECT produto, ROUND(preco, 2) AS preco_arredondado FROM produtos;

SELECT produto, ABS(quantidade) AS quantidade_absoluta FROM produtos;

SELECT AVG(preco) AS media_precos FROM produtos;

CREATE TABLE eventos (
    data_evento DATE
);

INSERT INTO eventos (data_evento)
VALUES ('2023-10-09'), ('2023-10-10'), ('2023-10-15');

INSERT INTO eventos (data_evento) VALUES (NOW());

SELECT DATEDIFF('2023-10-15', '2023-10-09') AS dias_entre_datas FROM eventos;

SELECT data_evento, DAYNAME(data_evento) AS dia_da_semana FROM eventos;


