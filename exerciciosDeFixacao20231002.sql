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

SELECT produto, IF(quantidade > 0, 'Em estoque', 'Fora de estoque') AS status_estoque FROM produtos;

SELECT produto,
       CASE
           WHEN preco < 10 THEN 'Barato'
           WHEN preco >= 10 AND preco < 20 THEN 'Médio'
           ELSE 'Caro'
       END AS categoria_preco
FROM produtos;

CREATE FUNCTION TOTAL_VALOR(preco DECIMAL, quantidade INT)
RETURNS DECIMAL(10, 2)
BEGIN
    RETURN preco * quantidade;
END;

SELECT produto, preco, quantidade, TOTAL_VALOR(preco, quantidade) AS valor_total FROM produtos;

SELECT COUNT(*) AS total_produtos FROM produtos;

SELECT COUNT(*) AS total_produtos FROM produtos;

SELECT produto, preco FROM produtos WHERE preco = (SELECT MIN(preco) FROM produtos);

SELECT SUM(IF(quantidade > 0, preco * quantidade, 0)) AS soma_total_em_estoque FROM produtos;

CREATE FUNCTION FATORIAL(n INT)
RETURNS INT
BEGIN
    IF n <= 1 THEN
        RETURN 1;
    ELSE
        RETURN n * FATORIAL(n - 1);
    END IF;
END;

CREATE FUNCTION EXPONENCIAL(base DECIMAL, expoente INT)
RETURNS DECIMAL(10, 2)
BEGIN
    RETURN POW(base, expoente);
END;

CREATE FUNCTION PALINDROMO(palavra VARCHAR(50))
RETURNS INT
BEGIN
    DECLARE reversed_word VARCHAR(50);
    SET reversed_word = REVERSE(palavra);
    IF palavra = reversed_word THEN
        RETURN 1;
    ELSE
        RETURN 0;
    END IF;
END;


