DROP DATABASE IF EXISTS Hospital;

-- Criando DataBase
CREATE DATABASE Hospital;
USE Hospital;

-- Desabilitando check de FKs em inserts
SET FOREIGN_KEY_CHECKS = 0;

-- Criando tabela Medico
CREATE TABLE Medico (
  id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  nome VARCHAR(45) NOT NULL,
  crm VARCHAR(45) NOT NULL,
  especialidade ENUM('cardio', 'neuro', 'psico', 'otorrino', 'pneumo') NOT NULL
);

-- Criando tabela Paciente
CREATE TABLE Paciente (
  id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  nome VARCHAR(45) NOT NULL,
  cpf VARCHAR(11) NOT null,
  plano ENUM('AMIL', 'SILVESTRE', 'SULAMERICA')
);

-- Criando tabela Consulta
CREATE TABLE Consulta (
  id INT AUTO_INCREMENT NOT NULL,
  medico_id INT NOT NULL,
  paciente_id INT NOT NULL,
  data DATETIME NOT NULL,
  CONSTRAINT `pk_consulta` PRIMARY KEY (id),
  CONSTRAINT `fk_medico` FOREIGN KEY (medico_id) REFERENCES Medico(id),
  CONSTRAINT `fk_paciente` FOREIGN KEY (paciente_id) REFERENCES Paciente(id)
);

-- Criando tabela Remedio
CREATE TABLE Remedio (
  ID INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  nome VARCHAR(25),
  preco FLOAT,
  planos_cobertos TEXT
);

-- Criando tabela Receita
CREATE TABLE Receita (
  consulta_id INT NOT NULL UNIQUE, -- É uma referência ao id da consulta
  descricao VARCHAR(255) NOT NULL,
  remedio_id INT not NULL,
  CONSTRAINT `fk_receita_consulta` fOREIGN KEY(consulta_id) REFERENCES Consulta(id),
  CONSTRAINT `fk_receita_remedio` fOREIGN KEY(remedio_id) REFERENCES Remedio(ID)
);

-- Inserts para tabela Medico (5 registros)
INSERT INTO Medico (nome, crm, especialidade) VALUES
('Dr. João Santos', '11111', 'cardio'),
('Dra. Maria Silva', '22222', 'neuro'),
('Dr. Pedro Barbosa', '33333', 'psico'),
('Dra. Ana Oliveira', '44444', 'otorrino'),
('Dr. Carlos Gomes', '55555', 'pneumo');

-- Inserts para tabela Paciente (9 registros)
INSERT INTO Paciente (nome, cpf, plano) VALUES
('Fulano da Silva', '11111111111', 'AMIL'),
('Cicrano Souza', '22222222222', 'SILVESTRE'),
('Beltrano Oliveira', '33333333333', 'SULAMERICA'),
('Maria Rodrigues', '44444444444', 'AMIL'),
('José Pereira', '55555555555', 'SILVESTRE'),
('Ana Silva', '66666666666', 'SULAMERICA'),
('Paulo Santos', '77777777777', 'AMIL'),
('Mariana Oliveira', '88888888888', 'SILVESTRE'),
('Pedro Gomes', '99999999999', 'SULAMERICA');

-- Inserts para tabela Consulta (12 registros)
INSERT INTO Consulta (medico_id, paciente_id, data) VALUES
(1, 1, '2022-01-01 09:00:00'),
(2, 2, '2022-01-02 10:30:00'),
(3, 3, '2022-01-03 14:15:00'),
(4, 4, '2022-01-04 16:45:00'),
(5, 5, '2022-01-01 11:30:00'),
(1, 6, '2022-01-02 13:00:00'),
(2, 7, '2022-01-03 10:00:00'),
(3, 8, '2022-01-01 15:45:00'),
(4, 9, '2022-01-03 17:30:00'),
(5, 1, '2022-01-01 09:30:00'),
(1, 2, '2022-01-02 16:00:00'),
(2, 3, '2022-01-04 14:45:00');

-- Inserts para tabela Remedio (15 registros)
INSERT INTO Remedio (nome, preco, planos_cobertos) VALUES
('Remedio 1', 10.5, 'AMIL,SILVESTRE'),
('Remedio 2', 20.75, 'AMIL'),
('Remedio 3', 15.0, 'SILVESTRE'),
('Remedio 4', 30.25, 'AMIL,SILVESTRE,SULAMERICA'),
('Remedio 5', 12.0, 'SULAMERICA'),
('Remedio 6', 18.5, NULL),
('Remedio 7', 25.0, 'AMIL,SULAMERICA'),
('Remedio 8', 8.75, 'SILVESTRE'),
('Remedio 9', 16.5, 'AMIL,SULAMERICA'),
('Remedio 10', 22.5, 'AMIL,SILVESTRE'),
('Remedio 11', 14.25, 'SILVESTRE,SULAMERICA'),
('Remedio 12', 17.75, 'AMIL'),
('Remedio 13', 11.5, 'SULAMERICA'),
('Remedio 14', 19.0, 'AMIL,SILVESTRE'),
('Remedio 15', 32.0, 'AMIL,SULAMERICA');

-- Inserts para tabela Receita (12 registros)
INSERT INTO Receita (consulta_id, descricao, remedio_id) VALUES
(1, 'Prescrição A', 1),
(2, 'Prescrição B', 2),
(3, 'Prescrição C', 3),
(4, 'Prescrição D', 4),
(5, 'Prescrição E', 5),
(6, 'Prescrição F', 6),
(7, 'Prescrição G', 7),
(8, 'Prescrição H', 8),
(9, 'Prescrição I', 9),
(10, 'Prescrição J', 10),
(11, 'Prescrição K', 11),
(12, 'Prescrição L', 12);


-- Habilitando check de FKs em inserts
SET FOREIGN_KEY_CHECKS = 1;
