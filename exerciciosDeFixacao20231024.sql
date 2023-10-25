CREATE DATABASE exercicios_trigger;
USE exercicios_trigger;

CREATE TABLE Clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL
);

CREATE TABLE Auditoria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    mensagem TEXT NOT NULL,
    data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    estoque INT NOT NULL
);
DELIMITER //
CREATE TRIGGER Before_Delete_Clientes
BEFORE DELETE ON Clientes
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria (mensagem)
    VALUES(CONCAT('Tentativa de exclusão de cliente em ', NOW()));
END;
//
DELIMITER ;

CREATE TABLE Pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    produto_id INT,
    quantidade INT NOT NULL,
    FOREIGN KEY (produto_id) REFERENCES Produtos(id)
);   DELIMITER //
CREATE TRIGGER After_Insert_Clientes
AFTER INSERT ON Clientes
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria (mensagem)
    VALUES(CONCAT('Novo cliente inserido em ', NOW()));
END;
//
DELIMITER ;
DELIMITER //
CREATE TRIGGER After_Update_Clientes
AFTER UPDATE ON Clientes
FOR EACH ROW
BEGIN
    IF OLD.nome <> NEW.nome THEN
        INSERT INTO Auditoria (mensagem)
        VALUES(CONCAT('Nome do cliente atualizado de "', OLD.nome, '" para "', NEW.nome, '" em ', NOW()));
    END IF;
END;
//
DELIMITER ;
DELIMITER //
CREATE TRIGGER Prevent_Empty_Name_Update
BEFORE UPDATE ON Clientes
FOR EACH ROW
BEGIN
    IF NEW.nome IS NULL OR NEW.nome = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tentativa de atualização do nome para string vazia ou NULL';
    END IF;
END;
//
DELIMITER ;
DELIMITER //
CREATE TRIGGER After_Insert_Pedidos
AFTER INSERT ON Pedidos
FOR EACH ROW
BEGIN
    UPDATE Produtos
    SET estoque = estoque - NEW.quantidade
    WHERE id = NEW.produto_id;

    IF NEW.quantidade > 5 THEN
        INSERT INTO Auditoria (mensagem)
        VALUES(CONCAT('Estoque do produto ', (SELECT nome FROM Produtos WHERE id = NEW.produto_id), ' ficou abaixo de 5 unidades em ', NOW()));
    END IF;
END;
//
DELIMITER ;
