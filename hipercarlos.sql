CREATE SCHEMA hipercarlos;

-- Criação da tabela Categoria
CREATE TABLE Categoria (
id_categoria INT PRIMARY KEY,
nome VARCHAR(100)
);

INSERT INTO Categoria () VALUES 
(1, 'Alimentos'),
(2, 'Higiene'),
(3, 'Limpeza'),
(4, 'Eletrônicos'),
(5, 'Roupas');

-- Criação da tabela Colaborador
CREATE TABLE Colaborador (
id_colab INT PRIMARY KEY,   
nome VARCHAR(100),    
salario DECIMAL(10,2)
);

-- Inserção dos registros na tabele Vendas
INSERT INTO Colaborador ()VALUES
(1, 'João Sá', 1200.56),
(2, 'Maria Silva', 1256.54),
(3, 'José Mário', 1300.51),
(4, 'Tamires Oliveira', 1500.36),
(5, 'Mariana Silva', 1290.66),
(6, 'Alice Maria', 1306.66);

-- Criação da tabela Vendas
CREATE TABLE Vendas (
id_venda INT PRIMARY KEY,    
produto VARCHAR(100),    
quantidade INT,    
preco_unidade DECIMAL(10,2),    
data_venda DATE,    
id_categoria INT,    
id_colab INT,    
FOREIGN KEY (id_categoria) REFERENCES Categoria (id_categoria),    
FOREIGN KEY (id_colab) REFERENCES Colaborador (id_colab)
);

-- Inserção dos registros na tabele Vendas 
INSERT INTO Vendas ()VALUES
(1, 'Arroz', 5, 10.00, '2024-09-01', 1, 1),
(2,  'Feijão', 3, 7.50, '2024-09-02', 1, 2),
(3,  'Sabão', 2, 12.00, '2024-09-02', 3, 1),
(4,  'Café', 6, 8.00, '2024-09-03', 1, 3),
(5,  'Detergente', 4, 5.00, '2024-09-03', 3, 4),
(6,  'Leite', 10, 4.50, '2024-09-04', 1, 6),
(7,  'Sabonete', 6, 3.00, '2024-09-04', 2, 3),
(8,  'Pão', 15, 1.50, '2024-09-05', 1, 1),
(9,  'Shampoo', 1, 15.00, '2024-09-05', 2, 2),
(10, 'Calça', 3, 150.00, '2024-09-06', 5, 5),
(11, 'Notebook', 3, 1499.99, '2024-09-06', 4, 6);

-- 1) Usando a função COUNT
-- a) Vendas realizadas na categoria Alimentos
SELECT COUNT(*) AS total_vendas
FROM Vendas
WHERE id_categoria = 1;

-- b) Vendas realizadas no total
SELECT id_categoria, SUM(quantidade) AS total_vendas
FROM Vendas
WHERE id_categoria = 1 ;

-- 2) Usando funçao AVG para calcular média
-- a) Preço médio por unidade de produtos vendidos
SELECT ROUND(AVG (preco_unidade),2) AS media_produtos
FROM Vendas;

-- b) Quantidade média de produtos vendidos por venda
SELECT ROUND(AVG (quantidade),2) AS media_vendaprodutos
FROM Vendas;

-- 3) Usando a função MIN e MAX para encontrar menor e maior valores
-- a) Encontrando o menor preço por unidade vendido
SELECT MIN(preco_unidade) AS menor_preco
FROM Vendas;

-- b) Encontrando o maior preço por unidade vendido
SELECT MAX(preco_unidade) AS maior_preco
FROM Vendas;

-- c) Encontrando a maior e menor quantidade de produtos vendidos em uma venda
SELECT MIN(quantidade) AS menor_quantidade
FROM Vendas;

SELECT MAX(quantidade) AS maior_quantidade
FROM Vendas;

-- 4) Combinando funçoes
-- a) Maior valor total de uma venda
SELECT MAX(preco_unidade * quantidade) AS maior_valor_venda
FROM Vendas;

-- b) Média do valor das vendas realizadas da categoria Higiene
SELECT ROUND(AVG(preco_unidade * quantidade),2) AS media_valor_vendas_higiene
FROM Vendas
WHERE id_categoria = 2;
