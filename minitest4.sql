CREATE TABLE usuarios(
    id SERIAL PRIMARY KEY,
    nickname VARCHAR(15) NOT NULL,
    date_nasc CHAR(10) CHECK (char_length(date_nasc) = 10),
    perfil_id INTEGER NOT NULL
);

CREATE TYPE estilo_musica AS ENUM ('R', 'P', 'E', 'A', 'C');
CREATE TABLE musicas(
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(30) NOT NULL,
    estilo estilo_musica NOT NULL
);

CREATE TABLE avaliacoes(
    id SERIAL PRIMARY KEY,
    nota  SMALLINT NOT NULL CHECK ((nota >= 0) AND (nota <= 5)),
    data CHAR(10) CHECK (char_length(data) = 10),
    musica_id INTEGER NOT NULL REFERENCES musicas (id) ON DELETE RESTRICT,
    usuario_id INTEGER NOT NULL REFERENCES usuarios (id)
);

CREATE TABLE perfis(
    id SERIAL PRIMARY KEY,
    descricao VARCHAR(15) NOT NULL,
    cadastra_usuario BOOLEAN NOT NULL,
    cadastra_musica BOOLEAN NOT NULL,
    faz_avaliacao BOOLEAN NOT NULL
);

ALTER TABLE usuarios ADD CONSTRAINT fkey FOREIGN KEY (perfil_id) REFERENCES
perfis (id) ON DELETE RESTRICT;
