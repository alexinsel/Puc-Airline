DROP TABLE TRECHOS;

DROP SEQUENCE SEQ_AEROPORTOS;
DROP TABLE AEROPORTOS;

DROP SEQUENCE SEQ_AERONAVES;
DROP TABLE AERONAVES;

CREATE TABLE AEROPORTOS(
    CODIGO INTEGER NOT NULL PRIMARY KEY, 
    NOME VARCHAR2(500) NOT NULL,
    SIGLA VARCHAR2(10) NOT NULL,
    CIDADE VARCHAR2(200) NOT NULL,
    PAIS VARCHAR2(100) NOT NULL,
    CONSTRAINT UN_SIGLA UNIQUE(SIGLA)
);

CREATE SEQUENCE SEQ_AEROPORTOS START WITH 1 INCREMENT BY 1;

CREATE TABLE AERONAVES(
    CODIGO INTEGER NOT NULL PRIMARY KEY,
    FABRICANTE VARCHAR2(100) NOT NULL,
    MODELO VARCHAR2(100) NOT NULL,
    ANO_FABRICACAO INTEGER NOT NULL,
    TOTAL_ASSENTOS INTEGER NOT NULL,
    REFERENCIA VARCHAR2(10) NOT NULL,
    CIDADE_ORIGEM VARCHAR2(50) NOT NULL,
    DATA_SAIDA VARCHAR2(10) NOT NULL,
    HORA_SAIDA VARCHAR2(10) NOT NULL,
    CIDADE_DESTINO VARCHAR(50) NOT NULL,
    DATA_CHEGADA VARCHAR2(10) NOT NULL,
    HORA_CHEGADA VARCHAR2(10) NOT NULL,
    
    CONSTRAINT CK_FABRICANTE_VALIDO CHECK 
        (FABRICANTE IN ('Airbus', 'Boeing', 'Embraer')),
        
    CONSTRAINT CK_ANO_VALIDO CHECK 
        (ANO_FABRICACAO BETWEEN 1990 AND 2023),

    CONSTRAINT CK_TOTAL_ASSENTOS CHECK
        (TOTAL_ASSENTOS BETWEEN 100 AND 1000),
    
    CONSTRAINT UN_REFERENCIA UNIQUE (REFERENCIA)
);

CREATE SEQUENCE SEQ_AERONAVES START WITH 1 INCREMENT BY 1;

CREATE TABLE TRECHOS(
    NOME VARCHAR2(200) NOT NULL,
    ORIGEM INTEGER NOT NULL,
    DESTINO INTEGER NOT NULL,
    AERONAVE INTEGER NOT NULL,
    
    CONSTRAINT CK_ORIGEM_DESTINO_DIFERENTES CHECK (ORIGEM != DESTINO),
    
    CONSTRAINT FK_ORIGEM_AEROPORTO FOREIGN KEY (ORIGEM) 
    REFERENCES AEROPORTOS(CODIGO),
    
    CONSTRAINT FK_DESTINO_AEROPORTO FOREIGN KEY (DESTINO)
    REFERENCES AEROPORTOS(CODIGO),
    
    CONSTRAINT FK_AERONAVE FOREIGN KEY(AERONAVE)
    REFERENCES AERONAVES(CODIGO)
    
);

INSERT INTO AEROPORTOS 
(CODIGO, NOME, SIGLA, CIDADE, PAIS)
VALUES
(SEQ_AEROPORTOS.NEXTVAL, 'Viracopos', 'VCP', 'Campinas', 'Brasil');

INSERT INTO AEROPORTOS 
(CODIGO, NOME, SIGLA, CIDADE, PAIS)
VALUES
(SEQ_AEROPORTOS.NEXTVAL, 'Garulhos', 'GRU', 'Guarulhos', 'Brasil');

INSERT INTO AEROPORTOS 
(CODIGO, NOME, SIGLA, CIDADE, PAIS)
VALUES
(SEQ_AEROPORTOS.NEXTVAL, 'Fort Lauderdale-Hollywood', 'FLL', 
'Fort Lauderdale', 'Estados Unidos');

INSERT INTO AEROPORTOS 
(CODIGO, NOME, SIGLA, CIDADE, PAIS)
VALUES
(SEQ_AEROPORTOS.NEXTVAL, 'Charles de Gaulle', 'CDG', 
'Paris', 'França');

INSERT INTO AEROPORTOS 
(CODIGO, NOME, SIGLA, CIDADE, PAIS)
VALUES
(SEQ_AEROPORTOS.NEXTVAL, 'Flughafen Zürich', 'ZRH', 
'Zürich', 'Suiça');

-- INSERINDO ALGUMAS AERONAVES

INSERT INTO AERONAVES
(CODIGO, FABRICANTE, MODELO, ANO_FABRICACAO, 
TOTAL_ASSENTOS, REFERENCIA) VALUES 
(SEQ_AERONAVES.NEXTVAL, 'Boeing', '797', 2000, 360, 'AB-1234');

INSERT INTO AERONAVES
(CODIGO, FABRICANTE, MODELO, ANO_FABRICACAO, 
TOTAL_ASSENTOS, REFERENCIA) VALUES 
(SEQ_AERONAVES.NEXTVAL, 'Airbus', 'A380', 2020, 900, 'AB-8974');

INSERT INTO AERONAVES
(CODIGO, FABRICANTE, MODELO, ANO_FABRICACAO, 
TOTAL_ASSENTOS, REFERENCIA) VALUES 
(SEQ_AERONAVES.NEXTVAL, 'Airbus', 'A320', 2022, 320, 'XP-4421');

INSERT INTO AERONAVES
(CODIGO, FABRICANTE, MODELO, ANO_FABRICACAO, 
TOTAL_ASSENTOS, REFERENCIA) VALUES 
(SEQ_AERONAVES.NEXTVAL, 'Embraer', 'E195-E2', 2022, 144, 'EM-9832');

-- TRECHOS
INSERT INTO TRECHOS
(NOME, ORIGEM, DESTINO, AERONAVE)
VALUES
('Campinas(vcp) - Fort Lauderdale(FLL)', 1, 3, 4);

INSERT INTO TRECHOS
(NOME, ORIGEM, DESTINO, AERONAVE)
VALUES
('Fort Lauderdale(FLL) - Campinas(vcp)', 3, 1, 4);

INSERT INTO TRECHOS
(NOME, ORIGEM, DESTINO, AERONAVE)
VALUES
('Campinas(vcp) - Fort Lauderdale(FLL)', 1, 3, 3);

INSERT INTO TRECHOS
(NOME, ORIGEM, DESTINO, AERONAVE) 
VALUES
('Fort Lauderdale(FLL) - Campinas(vcp)', 3, 1, 3);

INSERT INTO TRECHOS
(NOME, ORIGEM, DESTINO, AERONAVE)
VALUES
('Guarulhos(GRU) - Campinas(VCP)', 2, 1, 3);

INSERT INTO TRECHOS
(NOME, ORIGEM, DESTINO, AERONAVE)
VALUES
('Campinas(VCP) - Guarulhos(GRU)', 1, 2, 3);

INSERT INTO TRECHOS
(NOME, ORIGEM, DESTINO, AERONAVE)
VALUES
('Guarulhos(GRU) - Campinas(VCP)', 2, 1, 2);

INSERT INTO TRECHOS
(NOME, ORIGEM, DESTINO, AERONAVE)
VALUES
('Campinas(VCP) - Guarulhos(GRU)', 1, 2, 2);

COMMIT;

select * from aeronaves;