--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.14
-- Dumped by pg_dump version 9.5.14

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY public.tarefas DROP CONSTRAINT tarefas_pkey;
ALTER TABLE ONLY public.funcionario DROP CONSTRAINT funcionario_pkey;
DROP TABLE public.tarefas;
DROP TABLE public.funcionario;
SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: funcionario; Type: TABLE; Schema: public; Owner: abel
--

CREATE TABLE public.funcionario (
    cpf character(11) NOT NULL,
    data_nasc character(10) NOT NULL,
    nome character varying(50) NOT NULL,
    funcao character(11) NOT NULL,
    nivel character(1) NOT NULL,
    superior_cpf character(11),
    CONSTRAINT funcionario_cpf_check CHECK ((char_length(cpf) = 11)),
    CONSTRAINT funcionario_funcao_check CHECK ((funcao = ANY (ARRAY['LIMPEZA'::bpchar, 'SUP_LIMPEZA'::bpchar]))),
    CONSTRAINT funcionario_nivel_check CHECK ((nivel = ANY (ARRAY['J'::bpchar, 'P'::bpchar, 'S'::bpchar]))),
    CONSTRAINT funcionario_superior_cpf_check CHECK ((char_length(superior_cpf) = 11)),
    CONSTRAINT vrificafuncao CHECK (((funcao = 'SUP_LIMPEZA'::bpchar) OR ((funcao = 'LIMPEZA'::bpchar) AND (superior_cpf IS NOT NULL))))
);


ALTER TABLE public.funcionario OWNER TO abel;

--
-- Name: tarefas; Type: TABLE; Schema: public; Owner: abel
--

CREATE TABLE public.tarefas (
    id bigint NOT NULL,
    descricao character varying(100) NOT NULL,
    func_resp_cpf character(11) NOT NULL,
    prioridade smallint NOT NULL,
    status character(1) NOT NULL,
    CONSTRAINT lengthname CHECK ((char_length(func_resp_cpf) = 11)),
    CONSTRAINT prioridadeverifi CHECK (((prioridade >= 0) AND (prioridade <= 5))),
    CONSTRAINT statusvalid CHECK ((status = ANY (ARRAY['P'::bpchar, 'E'::bpchar, 'C'::bpchar])))
);


ALTER TABLE public.tarefas OWNER TO abel;

--
-- Data for Name: funcionario; Type: TABLE DATA; Schema: public; Owner: abel
--

INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678912', '1980-03-08', 'Jose da Silva', 'LIMPEZA    ', 'J', '12345678911');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678911', '1980-05-07', 'Pedro da Silva', 'SUP_LIMPEZA', 'S', NULL);


--
-- Data for Name: tarefas; Type: TABLE DATA; Schema: public; Owner: abel
--

INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483648, 'limpar portas do térreo', '32323232955', 4, 'P');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483653, 'limpar portas do 1o andar', '32323232911', 2, 'P');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483693, 'limpar portas do 1o andar', '32323232919', 2, 'P');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483647, 'limpar janelas da sala 203', '98765432122', 1, 'C');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483646, 'limpar chão do corredor central', '98765432111', 0, 'C');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483651, 'limpar portas do 1o andar', '32323232911', 5, 'P');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483652, 'limpar portas do 2o andar', '32323232911', 5, 'P');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483659, 'aparar a grama da área frontal', '21323232911', 1, 'P');


--
-- Name: funcionario_pkey; Type: CONSTRAINT; Schema: public; Owner: abel
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT funcionario_pkey PRIMARY KEY (cpf);


--
-- Name: tarefas_pkey; Type: CONSTRAINT; Schema: public; Owner: abel
--

ALTER TABLE ONLY public.tarefas
    ADD CONSTRAINT tarefas_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

