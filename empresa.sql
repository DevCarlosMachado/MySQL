CREATE SCHEMA empresa;

DROP TABLE departamentos;
CREATE TABLE departamentos (
   id INT AUTO_INCREMENT PRIMARY KEY,
   nome VARCHAR (100),
   bloco VARCHAR (50)
);

DROP TABLE empregados;
CREATE TABLE empregados (
   id INT AUTO_INCREMENT PRIMARY KEY,
   nome VARCHAR (100),
   matrícula INT,
   departamento_id INT,
   salárioR$ INT,
   FOREIGN KEY (departamento_id) REFERENCES departamentos(id) 
);

INSERT INTO departamentos (nome, bloco)
VALUES ("T.I", "Bloco A"),("ADM", "Bloco G"),("Financeiro", "Bloco B"),("Contabilidade", "Bloco C"),("Tesouraria", "Bloco D");

INSERT INTO empregados (nome, matrícula, departamento_id, salárioR$)
VALUES ("Carlos", "1003", "3", 1500), ("Alice", "5689" ,"2", 4000), ("Adely", "1205", "4", 2000), ("Lucas", "1414", "5", 4500), ("David", "8978", "3", 900.00);

select nome, matrícula from empregados;
select nome from empregados where matrícula <= 10500;

update empregados set departamento_id = 1 where id = 2;

delete from empregados where id = 5; 
delete from empregados;

start transaction;
update empregados set salárioR$ = salárioR$ * 2 where departamento_id = 1;
commit;
rollback;