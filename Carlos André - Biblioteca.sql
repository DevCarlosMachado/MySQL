CREATE SCHEMA Biblioteca;

-- Criação da tabela Biblioteca
CREATE TABLE Biblioteca (
id_livro INT AUTO_INCREMENT PRIMARY KEY,
titulo VARCHAR(100) NOT NULL,
autor VARCHAR(100) NOT NULL,
categoria VARCHAR(100) NOT NULL,
ano_publicacao YEAR NOT NULL,
editora VARCHAR(100) NOT NULL,
cidade_editora VARCHAR(50) NOT NULL,
ISBN BIGINT
);

-- Inserção de valores na tabela biblioteca 
INSERT INTO Biblioteca(titulo, autor, categoria, ano_publicacao, editora, cidade_editora, ISBN) VALUES
('Python Básico', 'João Sá', 'Programação', 2020, 'Novatec', 'São Paulo', 1254895632147),
('SQL Use a cabeça', 'Maria Silva', 'Banco de Dados', 2015, 'NovaEra', 'Recife', 1254784330149),
('Redes de computação', 'Matheus Oliveira', 'Redes', 2022, 'DarkSide', 'Rio de Janeiro', 1254895632147),
('Segurança de redes', 'Silveira Ferraz', 'Segurança', 2024, 'Intríseca', 'São Paulo', 1254784340150);

-- Criação da tabela usuário
CREATE TABLE usuario (
id_usuario INT AUTO_INCREMENT PRIMARY KEY,
id_livro INT,
nome VARCHAR(100),
data_emprestimo DATE,
data_devolucao DATE,
FOREIGN KEY (id_livro) REFERENCES Biblioteca(id_livro)
);

-- Inserção de valores na tabela usuário
INSERT INTO usuario(id_livro, nome, data_emprestimo, data_devolucao) VALUES
(3, 'Rogério Silva', '2024-05-08', '2024-05-15'),
(1, 'Alice Braz', '2024-08-09', '2024-08-16'),
(2, 'Talita Oliveira', '2024-07-01', '2024-07-08'),
(4, 'João Ricardo', '2024-10-05', '2024-10-15');


