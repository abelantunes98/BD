-- Questoes 1 e 2
-- Criando relacoes

CREATE TABLE AUTOMOVEL (
    placa CHAR(8),
    numFabricacao CHAR(17),
    numSinistros INTEGER,
    estado CHAR(2),
    anoFabricacao CHAR(4),
    cpfProprietario CHAR(11)
);

CREATE TABLE SEGURADO (
    nome VARCHAR(20),
    cpf CHAR(11),
    dataNas CHAR(10),
    numSinistros INTEGER,
    carNumFab CHAR(17),
    seguroId INTEGER
);

CREATE TABLE PERITO (
    nome VARCHAR(20),                                                               
    cpf CHAR(11),                                                   
    dataNas CHAR(10),                                                           
    ingresso TIMESTAMP,                                                         
    automoveisVerificados INTEGER
);

CREATE TABLE OFICINA (
    idOficina SERIAL,
    cnpj CHAR(16),
    proprietario VARCHAR(20),
    localidade VARCHAR(20)
);

CREATE TABLE SEGURO (
    idSeguro SERIAL,
    valor NUMERIC,
    cobreMoto BOOLEAN,
    cobreCarro BOOLEAN
);

CREATE TABLE SINISTRO (
    sinistroId SERIAL,
    tipoSinistro VARCHAR(10),
    dataHora TIMESTAMP,
    peritoCpf CHAR(11),
    seguradoCpf CHAR(11),
    periciaId INTEGER
);

CREATE TABLE PERICIA (
    idPericia SERIAL,
    numFabAutomovel CHAR(17),
    laudo VARCHAR(50),
    tipoPericia VARCHAR(7)
);

CREATE TABLE REPARO (
    idReparo SERIAL,	
    valor NUMERIC,
    data TIMESTAMP,
    oficinaId INTEGER,
    veiculoId CHAR (17),
    detalhes VARCHAR (30)
);

-- Questao 3 
-- Definindo chaves primarias
ALTER TABLE AUTOMOVEL ADD PRIMARY KEY (numFabricacao);
ALTER TABLE SEGURADO ADD PRIMARY KEY (cpf);
ALTER TABLE PERITO ADD PRIMARY KEY (cpf);
ALTER TABLE OFICINA ADD PRIMARY KEY (idOficina);
ALTER TABLE SEGURO ADD PRIMARY KEY (idSeguro);
ALTER TABLE SINISTRO ADD PRIMARY KEY (sinistroId);
ALTER TABLE PERICIA ADD PRIMARY KEY (idPericia);
ALTER TABLE REPARO ADD PRIMARY KEY (idReparo);

-- Questao 4
-- Adicionando chaves estrangeiras
ALTER TABLE AUTOMOVEL ADD FOREIGN KEY (cpfProprietario) REFERENCES SEGURADO (cpf);
ALTER TABLE SEGURADO ADD FOREIGN KEY (carNumFab) REFERENCES AUTOMOVEL (numFabricacao);
ALTER TABLE SEGURADO ADD FOREIGN KEY (seguroId) REFERENCES SEGURO (idSeguro);
ALTER TABLE SINISTRO ADD FOREIGN KEY (seguradoCpf) REFERENCES SEGURADO (cpf);
ALTER TABLE SINISTRO ADD FOREIGN KEY (peritoCpf) REFERENCES PERITO (cpf);
ALTER TABLE SINISTRO ADD FOREIGN KEY (periciaId) REFERENCES PERICIA (idPericia);
ALTER TABLE PERICIA ADD FOREIGN KEY (numFabAutomovel) REFERENCES AUTOMOVEL (numFabricacao);
ALTER TABLE REPARO ADD FOREIGN KEY (veiculoId) REFERENCES AUTOMOVEL (numFabricacao);
ALTER TABLE REPARO ADD FOREIGN KEY (oficinaId) REFERENCES OFICINA (idOficina);

-- Questao 6
-- Removendo tabelas
DROP TABLE AUTOMOVEL CASCADE;
DROP TABLE OFICINA CASCADE;
DROP TABLE PERICIA CASCADE;
DROP TABLE PERITO CASCADE;
DROP TABLE REPARO CASCADE;
DROP TABLE SEGURADO CASCADE;
DROP TABLE SEGURO CASCADE;
DROP TABLE SINISTRO CASCADE;

-- Questao 8
-- Criando tabelas ja com restricoes

CREATE TABLE AUTOMOVEL (
    placa CHAR(8) NOT NULL,
    numFabricacao CHAR(17) PRIMARY KEY NOT NULL,
    numSinistros INTEGER,
    estado CHAR(2) NOT NULL,
    anoFabricacao CHAR(4) NOT NULL,
    cpfProprietario CHAR(11) NOT NULL
);

CREATE TABLE SEGURADO (
    nome VARCHAR(20) NOT NULL, 
    cpf CHAR(11) PRIMARY KEY NOT NULL,
    dataNas CHAR(10) NOT NULL,
    numSinistros INTEGER,
    carNumFab CHAR(17),
    seguroId INTEGER,
    FOREIGN KEY (carNumFab) REFERENCES AUTOMOVEL (numFabricacao)
);

CREATE TABLE PERITO (
    nome VARCHAR(20) NOT NULL,                                                               
    cpf CHAR(11) PRIMARY KEY NOT NULL,                                                   
    dataNas CHAR(10) NOT NULL,                                                           
    ingresso TIMESTAMP NOT NULL,                                                         
    automoveisVerificados INTEGER
);

CREATE TABLE OFICINA (
    cnpj CHAR(16) PRIMARY KEY NOT NULL,
    proprietario VARCHAR(20) NOT NULL,
    localidade VARCHAR(20) NOT NULL
);

CREATE TABLE SEGURO (
    idSeguro SERIAL,
    valor NUMERIC,
    cobreMoto BOOLEAN,
    cobreCarro BOOLEAN
);

CREATE TABLE PERICIA (
    idPericia SERIAL PRIMARY KEY,
    numFabAutomovel CHAR(17) NOT NULL REFERENCES AUTOMOVEL (numFabricacao),
    laudo VARCHAR(50) NOT NULL,
    tipoPericia VARCHAR(7) NOT NULL
);

CREATE TABLE SINISTRO (
    sinistroId SERIAL,
    tipoSinistro VARCHAR(10) NOT NULL,
    dataHora TIMESTAMP NOT NULL,
    peritoCpf CHAR(11) REFERENCES PERITO (cpf),
    seguradoCpf CHAR(11) REFERENCES SEGURADO (cpf),
    periciaId INTEGER REFERENCES PERICIA (idPericia) 
);


CREATE TABLE REPARO (
    idReparo SERIAL PRIMARY KEY,	
    valor NUMERIC NOT NULL,
    data TIMESTAMP NOT NULL,
    oficinaId CHAR (16) NOT NULL REFERENCES OFICINA (cnpj),
    veiculoId CHAR (17) NOT NULL REFERENCES AUTOMOVEL (numFabricacao),
    detalhes VARCHAR (30)
);








    
    
     
