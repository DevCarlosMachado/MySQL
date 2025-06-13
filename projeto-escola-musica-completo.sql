-- Script completo do projeto Escola de Música
-- Gerado em 2025-05-16 02:36:20

-- 1. Remover e recriar o banco de dados
DROP DATABASE IF EXISTS EscolaMusica;
CREATE DATABASE EscolaMusica;
USE EscolaMusica;

-- 2. Criação das tabelas
CREATE TABLE Orquestra (
    id_orquestra INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE Musico (
    id_musico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    ativo BOOLEAN NOT NULL,
    id_orquestra INT,
    FOREIGN KEY (id_orquestra) REFERENCES Orquestra(id_orquestra)
);

CREATE TABLE Instrumento (
    id_instrumento INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    familia VARCHAR(100) NOT NULL
);

CREATE TABLE Musico_Instrumento (
    id_musico INT,
    id_instrumento INT,
    PRIMARY KEY (id_musico, id_instrumento),
    FOREIGN KEY (id_musico) REFERENCES Musico(id_musico),
    FOREIGN KEY (id_instrumento) REFERENCES Instrumento(id_instrumento)
);

CREATE TABLE Sinfonia (
    id_sinfonia INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    duracao INT NOT NULL,
    compositor VARCHAR(100) NOT NULL
);

CREATE TABLE Funcao_Musico_Sinfonia (
    id_musico INT,
    id_sinfonia INT,
    funcao VARCHAR(50),
    data_inicio DATE,
    data_fim DATE,
    PRIMARY KEY (id_musico, id_sinfonia, funcao),
    FOREIGN KEY (id_musico) REFERENCES Musico(id_musico),
    FOREIGN KEY (id_sinfonia) REFERENCES Sinfonia(id_sinfonia)
);

-- 3. Inserção de dados
INSERT INTO Orquestra (nome) VALUES 
('Filarmônica Jovem'), ('Orquestra Clássica');

INSERT INTO Musico (nome, ativo, id_orquestra) VALUES 
('Ana', TRUE, 1),
('Carlos', TRUE, 1),
('Beatriz', FALSE, 2),
('Daniel', TRUE, 2);

INSERT INTO Instrumento (nome, familia) VALUES 
('Violino', 'Cordas'),
('Viola', 'Cordas'),
('Trompete', 'Metais'),
('Flauta', 'Madeiras'),
('Piano', 'Teclas');

INSERT INTO Musico_Instrumento (id_musico, id_instrumento) VALUES 
(1, 1), (1, 2), (2, 3), (3, 4), (4, 5);

INSERT INTO Sinfonia (nome, duracao, compositor) VALUES 
('Sinfonia nº 5', 45, 'Beethoven'),
('Sinfonia nº 9', 70, 'Dvorak');

INSERT INTO Funcao_Musico_Sinfonia (id_musico, id_sinfonia, funcao, data_inicio, data_fim) VALUES 
(1, 1, 'Solista', '2024-01-01', '2024-01-30'),
(2, 1, 'Maestro', '2024-01-01', '2024-01-30'),
(4, 2, 'Maestro', '2024-02-01', '2024-02-28');

-- 4. Criação das Views
CREATE OR REPLACE VIEW vw_Musicos_Orquestras AS
SELECT m.nome AS musico, o.nome AS orquestra
FROM Musico m
JOIN Orquestra o ON m.id_orquestra = o.id_orquestra;

CREATE OR REPLACE VIEW vw_Sinfonias_Compositores AS
SELECT nome, compositor FROM Sinfonia;

CREATE OR REPLACE VIEW vw_Instrumentos_Musicos AS
SELECT i.nome AS instrumento, m.nome AS musico
FROM Instrumento i
JOIN Musico_Instrumento mi ON i.id_instrumento = mi.id_instrumento
JOIN Musico m ON mi.id_musico = m.id_musico;

CREATE OR REPLACE VIEW vw_Funcoes_Sinfonias AS
SELECT m.nome AS musico, s.nome AS sinfonia, f.funcao
FROM Funcao_Musico_Sinfonia f
JOIN Musico m ON f.id_musico = m.id_musico
JOIN Sinfonia s ON f.id_sinfonia = s.id_sinfonia;

CREATE OR REPLACE VIEW vw_Musicos_MultiplosInstrumentos AS
SELECT m.nome, COUNT(mi.id_instrumento) AS qtd_instrumentos
FROM Musico m
JOIN Musico_Instrumento mi ON m.id_musico = mi.id_musico
GROUP BY m.id_musico
HAVING qtd_instrumentos > 1;

CREATE OR REPLACE VIEW vw_Instrumentos_PorFamilia AS
SELECT familia, COUNT(*) AS qtd_instrumentos
FROM Instrumento
GROUP BY familia;

CREATE OR REPLACE VIEW vw_Musicos_Ativos_Violino AS
SELECT m.nome
FROM Musico m
JOIN Musico_Instrumento mi ON m.id_musico = mi.id_musico
JOIN Instrumento i ON mi.id_instrumento = i.id_instrumento
WHERE m.ativo = TRUE AND i.nome = 'Violino';

CREATE OR REPLACE VIEW vw_Orquestras_Com_Piano AS
SELECT DISTINCT o.nome
FROM Orquestra o
JOIN Musico m ON o.id_orquestra = m.id_orquestra
JOIN Musico_Instrumento mi ON m.id_musico = mi.id_musico
JOIN Instrumento i ON mi.id_instrumento = i.id_instrumento
WHERE i.nome = 'Piano';

CREATE OR REPLACE VIEW vw_Sinfonias_Duracao AS
SELECT nome, duracao FROM Sinfonia WHERE duracao > 40;

CREATE OR REPLACE VIEW vw_Musicos_Maestros AS
SELECT m.nome
FROM Musico m
JOIN Funcao_Musico_Sinfonia f ON m.id_musico = f.id_musico
WHERE f.funcao = 'Maestro';


-- 5. Atualizações (DML - UPDATE e DELETE)
-- Atualizar o nome de um músico
UPDATE Musico SET nome = 'Ana Clara' WHERE nome = 'Ana';

-- Atualizar a nacionalidade (adicionando coluna temporariamente)
ALTER TABLE Musico ADD nacionalidade VARCHAR(50);
UPDATE Musico SET nacionalidade = 'Brasileira' WHERE nome = 'Ana Clara';

-- Atualizar a família de um instrumento
UPDATE Instrumento SET familia = 'Cordas Friccionadas' WHERE nome = 'Violino';

-- Desativar músico
UPDATE Musico SET ativo = FALSE WHERE nome = 'Carlos';

-- Mudar compositor
UPDATE Sinfonia SET compositor = 'Antonín Dvořák' WHERE nome = 'Sinfonia nº 9';

-- Deletar relação de músico com instrumento
DELETE FROM Musico_Instrumento WHERE id_musico = 3 AND id_instrumento = 4;

-- Deletar função de músico
DELETE FROM Funcao_Musico_Sinfonia WHERE id_musico = 2 AND id_sinfonia = 1;

-- Deletar sinfonia
DELETE FROM Funcao_Musico_Sinfonia WHERE id_sinfonia = 2;
DELETE FROM Sinfonia WHERE id_sinfonia = 2;

-- Deletar instrumento
DELETE FROM Musico_Instrumento WHERE id_instrumento = 5;
DELETE FROM Instrumento WHERE id_instrumento = 5;

-- Deletar músico
DELETE FROM Funcao_Musico_Sinfonia WHERE id_musico = 4;
DELETE FROM Musico_Instrumento WHERE id_musico = 4;
DELETE FROM Musico WHERE id_musico = 4;

-- 6. Consultas (DQL - SELECTs com JOINs/Subqueries)
-- Músicos e seus instrumentos
SELECT m.nome, i.nome AS instrumento
FROM Musico m
JOIN Musico_Instrumento mi ON m.id_musico = mi.id_musico
JOIN Instrumento i ON mi.id_instrumento = i.id_instrumento;

-- Músicos ativos
SELECT nome FROM Musico WHERE ativo = TRUE;

-- Orquestras com mais de 1 músico
SELECT o.nome
FROM Orquestra o
JOIN Musico m ON o.id_orquestra = m.id_orquestra
GROUP BY o.id_orquestra
HAVING COUNT(m.id_musico) > 1;

-- Instrumentos por músico
SELECT m.nome, COUNT(mi.id_instrumento) AS qtd
FROM Musico m
JOIN Musico_Instrumento mi ON m.id_musico = mi.id_musico
GROUP BY m.id_musico;

-- Músicos que tocam Violino
SELECT m.nome
FROM Musico m
JOIN Musico_Instrumento mi ON m.id_musico = mi.id_musico
JOIN Instrumento i ON mi.id_instrumento = i.id_instrumento
WHERE i.nome = 'Violino';

-- Sinfonias executadas por 'Ana Clara'
SELECT s.nome
FROM Funcao_Musico_Sinfonia f
JOIN Musico m ON f.id_musico = m.id_musico
JOIN Sinfonia s ON f.id_sinfonia = s.id_sinfonia
WHERE m.nome = 'Ana Clara';

-- Instrumentos da família 'Cordas'
SELECT nome FROM Instrumento WHERE familia = 'Cordas';

-- Orquestra com mais músicos
SELECT o.nome
FROM Orquestra o
JOIN Musico m ON o.id_orquestra = m.id_orquestra
GROUP BY o.id_orquestra
ORDER BY COUNT(m.id_musico) DESC
LIMIT 1;

-- Funções de músicos
SELECT m.nome, f.funcao
FROM Funcao_Musico_Sinfonia f
JOIN Musico m ON f.id_musico = m.id_musico;

-- Músico que nunca tocou sinfonia
SELECT nome FROM Musico
WHERE id_musico NOT IN (
    SELECT DISTINCT id_musico FROM Funcao_Musico_Sinfonia
);

-- 7. Script para destruir tudo (DROP)
DROP VIEW IF EXISTS 
    vw_Musicos_Orquestras,
    vw_Sinfonias_Compositores,
    vw_Instrumentos_Musicos,
    vw_Funcoes_Sinfonias,
    vw_Musicos_MultiplosInstrumentos,
    vw_Instrumentos_PorFamilia,
    vw_Musicos_Ativos_Violino,
    vw_Orquestras_Com_Piano,
    vw_Sinfonias_Duracao,
    vw_Musicos_Maestros;

DROP TABLE IF EXISTS 
    Funcao_Musico_Sinfonia,
    Musico_Instrumento,
    Musico,
    Instrumento,
    Sinfonia,
    Orquestra;
