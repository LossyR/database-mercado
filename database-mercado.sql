CREATE DATABASE mercado;
use mercado;

CREATE TABLE produto(
codigo VARCHAR (3) PRIMARY KEY,
descricao VARCHAR (50) UNIQUE,
estoque INT NOT NULL DEFAULT 0
);

INSERT INTO produto (codigo, descricao, estoque) VALUES
('001', 'leite', 30),
('002', 'café', 50),
('003', 'arroz', 20); 

CREATE TABLE venda (
venda INT,
produto VARCHAR (3),
quantidade INT
);

INSERT INTO venda VALUES
(1, '001', 5),
(1, '001', 5),
(1, '003', 5);

DELIMITER $

CREATE TRIGGER venda_insert AFTER INSERT
ON venda
FOR EACH ROW
BEGIN
	UPDATE produto SET estoque = estoque - NEW.quantidade
WHERE codigo = NEW.produto;
END$

CREATE TRIGGER venda_delete AFTER DELETE
ON venda
FOR EACH ROW
BEGIN
	UPDATE produto SET estoque = estoque + OLD.quantidade
WHERE codigo = OLD.produto;
END$

DELIMITER ;


DELETE FROM venda WHERE venda = 1 AND produto = '001';

SELECT * FROM produto;
