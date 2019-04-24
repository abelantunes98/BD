-- Criando tabela 

CREATE TABLE tarefas(                                                 
cpf INTEGER,
funcao VARCHAR(100),
telefone CHAR(11),
value smallint,
logica CHAR(1));

-- Questao 1
insert into tarefas values(2147483646, 'limpar chão do corredor central', '98765432111', 0, 'F');
insert into tarefas values(2147483647, 'limpar janelas da sala 203', '98765432122', 1, 'F');
insert into tarefas values(null, null, null, null, null);
insert into tarefas values(2147483647, 'limpar janelas da sala 203', '98765432321', 1, 'FF');
insert into tarefas values(2147483643, 'limpar janelas da sala 203', '98765432311', 1, 'FF');

-- Questao 2
insert into tarefas values (2147483644, 'limpar chão do corredor superior', '987654323211', 0, 'F');
alter table tarefas alter column cpf type bigint;

-- Questao 3
insert into tarefas values (2147483649, 'limpar portas da entrada principal', '32322525199', 32768, 'A');
insert into tarefas values (2147483650, 'limpar portas da entrada principal', '32322525199', 32769, 'A');
insert into tarefas values (2147483651, 'limpar portas do 1o andar', '32323232911', 32767, 'A');
insert into tarefas values(2147483652, 'limpar portas do 2o andar',
'32323232911', 32766, 'A');

-- Questao 4
alter table tarefas rename column cpf to id;
alter table tarefas rename column funcao to descricao;
alter table tarefas rename column telefone to func_resp_cpf;
alter table tarefas rename column value to prioridade;
alter table tarefas rename column logica to status;

delete from tarefas where id is null;
alter table tarefas alter column id set not null;
alter table tarefas alter column descricao set not null;
alter table tarefas alter column func_resp_cpf set not null;
alter table tarefas alter column prioridade set not null;
alter table tarefas alter column status set not null;

-- Questao 5
insert into tarefas values (2147483653, 'limpar portas do 1o andar', '32323232911', 2, 'A');
insert into tarefas values (2147483653, 'aparar a grama da área frontal', '32323232911', 3, 'A');
delete from tarefas where prioridade = 3;
alter table tarefas add primary key (id);
insert into tarefas values (2147483653, 'aparar a grama da área frontal', '32323232911', 3, 'A');

-- Questao 6

--a)
alter table tarefas add constraint lengthName CHECK (char_length(func_resp_cpf) = 11);

--b)
-- Alterando os que estao com valores anteriormente validos A ou F
update tarefas set status = 'P' where status = 'A';
update tarefas set status = 'C' where status = 'F';

-- Adicionando novos valores permitidos
alter table tarefas add constraint statusValid CHECK(status in ('P', 'E', 'C'));

-- Questao 7
-- Prioridade pode variar entre 0 e 5
alter table tarefas add constraint prioridadeverifi CHECK (prioridade >= 0 AND prioridade <= 5);

-- Questao 8

create table funcionario (
	    cpf CHAR(11) NOT NULL PRIMARY KEY CHECK(char_length(cpf) = 11),
	    data_nasc CHAR(10) NOT NULL,
	    nome VARCHAR(50) NOT NULL,
	    funcao CHAR(11) NOT NULL CHECK(funcao in ('LIMPEZA', 'SUP_LIMPEZA')),
	    nivel CHAR(1) NOT NULL CHECK(nivel in ('J', 'P', 'S')),
	    superior_cpf CHAR(11) NOT NULL CHECK(char_length(superior_cpf) = 11)
);

alter table funcionario add constraint verificaFuncao CHECK((funcao = 'SUP_LIMPEZA' OR (funcao = 'LIMPEZA' AND superior_cpf != NULL)));

insert into funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) values ('12345678911', '1980-05-07', 'Pedro da Silva', 'SUP_LIMPEZA', 'S', null);

insert into funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) values ('12345678912', '1980-03-08', 'Jose da Silva', 'LIMPEZA', 'J', '12345678911');

insert into funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) values ('12345678913', '1980-04-09', 'Joao da Silva', 'LIMPEZA', 'J', null);

-- Questao 9
-- Adicionando valores validos
insert into funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) values ('12345678914', '1980-05-18', 'Mario da Silva', 'LIMPEZA', 'J', '12345678911');

insert into funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) values ('12345678915', '1980-06-07', 'Marta', 'SUP_LIMPEZA', 'S', null);

insert into funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) values ('12345678916', '1980-02-08', 'Josemar da Silva', 'LIMPEZA', 'J', '12345678915');

insert into funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) values ('12345678917', '1980-04-11', 'Rose da Silva', 'LIMPEZA', 'J', '12345678915');

insert into funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) values ('12345678918', '1990-11-08', 'Marta Lima', 'SUP_LIMPEZA', 'P', '12345678911');

insert into funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) values ('12345678919', '1992-12-09', 'Antunes', 'LIMPEZA', 'J', '12345678918');

insert into funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) values ('12345678920', '1990-11-08', 'Gil Silva', 'LIMPEZA', 'J', '12345678911');

insert into funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) values ('12345678921', '1997-02-09', 'Josefa', 'LIMPEZA', 'J', '12345678918');

insert into funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) values ('12345678922', '1970-03-07', 'Josil', 'LIMPEZA', 'P', '12345678911');

insert into funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) values ('12345678923', '1980-11-11', 'Luciene', 'LIMPEZA', 'P', '12345678918');

-- Valores que nao funcionam

-- Nivel invalido
insert into funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) values ('12345678924', '1980-11-11', 'Luciene', 'LIMPEZA', 'F', '12345678918');

-- Cpf com menos de 11 digitos
insert into funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) values ('123456789', '1980-11-11', 'Luciene', 'LIMPEZA', 'F', '12345678918');
	
-- Cpf com menos de 11 digitos
insert into funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) values ('123456789', '1980-11-11', 'Luciene', 'LIMPEZA', 'C', '12345678918');

-- Cpf com mais de 11 digito
insert into funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) values ('123456789665555', '1980-11-11', 'Luciene', 'LIMPEZA', 'C', '12345678');

-- Cpf com mais de 11 digito
insert into funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) values ('12345678966', '1980-11-11', 'Luciene', 'LIMPEZA', 'C', '123456785555555');

-- Cpf null
insert into funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) values (null, '1980-11-11', 'Luciene', 'LIMPEZA', 'C', '12345678111');

-- Data null
insert into funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) values ('12345678966', null, 'Luciene', 'LIMPEZA', 'C', '12345678555');

-- Nome null
insert into funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) values ('12345678966', 1998-09-09, null, 'LIMPEZA', 'C', '12345678555');

-- Cpf superior null sendo da limpeza
insert into funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) values ('12345678966', 1998-09-09, null, 'LIMPEZA', 'C', null);

-- Nivel invalido
insert into funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) values ('12345678966', 1998-09-09, null, 'LIMPEZA', 'l', '12345678555');


-- Questao 10

INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('32323232955', '1995-10-24', 'Laura', 'LIMPEZA', 'J', '12305579462');

abel_db=> INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('32323232911', '1994-10-24', 'Abel', 'SUP_LIMPEZA', 'S', null);

abel_db=> INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('32323232919', '1994-10-24', 'Mario', 'LIMPEZA', 'J', '32323232911');

abel_db=> INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('98765432122', '1994-10-24', 'Maria', 'LIMPEZA', 'J', '32323232911');

abel_db=> INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('98765432111', '1994-10-24', 'Melly', 'LIMPEZA', 'J', '32323232911');

abel_db=> INSERT INTO funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('21323232911', '1994-10-24', 'Funny', 'LIMPEZA', 'J', '32323232911');

-- Não permite que sej apagado se estiver referenciado em outra tabela
-- Nesse caso precisa apagar logo na tabela que faz referencia, depois na que é referenciada.
ALTER TABLE tarefas ADD CONSTRAINT funcionario_cpf_fkey FOREIGN kEY (func_resp_cpf) REFERENCES funcionario (cpf) ON DELETE RESTRICT;

-- Apaga usando cascata onde está referenciado.
ALTER TABLE tarefas ADD CONSTRAINT funcionario_cpf_fkey FOREIGN kEY (func_resp_cpf) REFERENCES funcionario (cpf) ON DELETE CASCADE;

-- Questao 11
-- Se o status for 'E' o cpf não pode ser null.
ALTER TABLE tarefas ADD CONSTRAINT id_not_null_verify CHECK ((status != 'E') or (func_resp_cpf is not null));

-- Quando deleta algo que está referenciado, transforma as referencias em null.
ALTER TABLE tarefas ADD CONSTRAINT funcionario_cpf_fkey FOREIGN kEY (func_resp_cpf) REFERENCES funcionario (cpf) ON DELETE SET NULL;

-- Como foi criada a constraint id_not_null_verify não é possivel setar o id como nulllogo, não há como apagar os que possuem status 'E', aparece o erro :

ERROR:  new row for relation "tarefas" violates check constraint "id_not_null_verify"
DETAIL:  Failing row contains (11235456850, test, null, 4, E).
CONTEXT:  SQL statement "UPDATE ONLY "public"."tarefas" SET "func_resp_cpf" = NULL WHERE $1 OPERATOR(pg_catalog.=) "func_resp_cpf""
