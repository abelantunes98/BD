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

ALTER TABLE ONLY public.vendas DROP CONSTRAINT vendas_cpf_cliente_fkey;
ALTER TABLE ONLY public.vendas DROP CONSTRAINT medicamentos_fkey;
ALTER TABLE ONLY public.vendas DROP CONSTRAINT funcionarios_fkey;
ALTER TABLE ONLY public.farmacias DROP CONSTRAINT funcionarios_fkey;
ALTER TABLE ONLY public.farmacia_funcionario DROP CONSTRAINT farmacia_funcionario_id_farmacia_fkey;
ALTER TABLE ONLY public.farmacia_funcionario DROP CONSTRAINT farmacia_funcionario_cpf_funcionario_fkey;
ALTER TABLE ONLY public.entregas DROP CONSTRAINT entregas_id_endereco_entrega_fkey;
ALTER TABLE ONLY public.enderecos_clientes DROP CONSTRAINT enderecos_clientes_cliente_cpf_fkey;
ALTER TABLE ONLY public.vendas DROP CONSTRAINT vendas_pkey;
ALTER TABLE ONLY public.farmacias DROP CONSTRAINT unica_sede;
ALTER TABLE ONLY public.farmacias DROP CONSTRAINT unica_farmacia_por_bairro;
ALTER TABLE ONLY public.medicamentos DROP CONSTRAINT medicamentos_pkey;
ALTER TABLE ONLY public.medicamentos DROP CONSTRAINT medicamentos_id_key;
ALTER TABLE ONLY public.funcionarios DROP CONSTRAINT funcionarios_pkey;
ALTER TABLE ONLY public.funcionarios DROP CONSTRAINT funcionarios_cpf_key;
ALTER TABLE ONLY public.farmacias DROP CONSTRAINT farmacias_pkey;
ALTER TABLE ONLY public.farmacia_funcionario DROP CONSTRAINT farmacia_funcionario_pkey;
ALTER TABLE ONLY public.farmacia_funcionario DROP CONSTRAINT farmacia_funcionario_cpf_funcionario_key;
ALTER TABLE ONLY public.entregas DROP CONSTRAINT entregas_pkey;
ALTER TABLE ONLY public.enderecos_clientes DROP CONSTRAINT enderecos_clientes_pkey;
ALTER TABLE ONLY public.clientes DROP CONSTRAINT clientes_pkey;
ALTER TABLE public.vendas ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.medicamentos ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.farmacias ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.entregas ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.enderecos_clientes ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE public.vendas_id_seq;
DROP TABLE public.vendas;
DROP SEQUENCE public.medicamentos_id_seq;
DROP TABLE public.medicamentos;
DROP TABLE public.funcionarios;
DROP SEQUENCE public.farmacias_id_seq;
DROP TABLE public.farmacias;
DROP TABLE public.farmacia_funcionario;
DROP SEQUENCE public.entregas_id_seq;
DROP TABLE public.entregas;
DROP SEQUENCE public.enderecos_clientes_id_seq;
DROP TABLE public.enderecos_clientes;
DROP TABLE public.clientes;
DROP DOMAIN public.gerente_funcao_dom;
DROP DOMAIN public.funcionarios_funcao_dom;
DROP DOMAIN public.estados_nordeste;
DROP DOMAIN public.cpf_valido;
DROP EXTENSION btree_gist;
DROP EXTENSION plpgsql;
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: btree_gist; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS btree_gist WITH SCHEMA public;


--
-- Name: EXTENSION btree_gist; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION btree_gist IS 'support for indexing common datatypes in GiST';


--
-- Name: cpf_valido; Type: DOMAIN; Schema: public; Owner: abel
--

CREATE DOMAIN public.cpf_valido AS character(11) NOT NULL
	CONSTRAINT cpf_valido_check CHECK ((char_length(VALUE) = 11));


ALTER DOMAIN public.cpf_valido OWNER TO abel;

--
-- Name: estados_nordeste; Type: DOMAIN; Schema: public; Owner: abel
--

CREATE DOMAIN public.estados_nordeste AS character(2) NOT NULL
	CONSTRAINT estados_nordeste_check CHECK ((VALUE = ANY (ARRAY['AL'::bpchar, 'BA'::bpchar, 'CE'::bpchar, 'MA'::bpchar, 'PB'::bpchar, 'PE'::bpchar, 'PI'::bpchar, 'RN'::bpchar, 'SE'::bpchar])));


ALTER DOMAIN public.estados_nordeste OWNER TO abel;

--
-- Name: funcionarios_funcao_dom; Type: DOMAIN; Schema: public; Owner: abel
--

CREATE DOMAIN public.funcionarios_funcao_dom AS character varying(13) NOT NULL
	CONSTRAINT funcionarios_funcao_dom_check CHECK (((VALUE)::text = ANY ((ARRAY['administrador'::character varying, 'farmaceutico'::character varying, 'vendedor'::character varying, 'entregador'::character varying, 'caixa'::character varying])::text[])));


ALTER DOMAIN public.funcionarios_funcao_dom OWNER TO abel;

--
-- Name: gerente_funcao_dom; Type: DOMAIN; Schema: public; Owner: abel
--

CREATE DOMAIN public.gerente_funcao_dom AS public.funcionarios_funcao_dom
	CONSTRAINT gerente_funcao_dom_check CHECK (((VALUE)::text = ANY ((ARRAY['administrador'::character varying, 'farmaceutico'::character varying])::text[])));


ALTER DOMAIN public.gerente_funcao_dom OWNER TO abel;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: clientes; Type: TABLE; Schema: public; Owner: abel
--

CREATE TABLE public.clientes (
    cpf public.cpf_valido NOT NULL,
    nome character varying(20),
    sobrenome character varying(20),
    idade integer,
    CONSTRAINT clientes_idade_check CHECK ((idade >= 18))
);


ALTER TABLE public.clientes OWNER TO abel;

--
-- Name: enderecos_clientes; Type: TABLE; Schema: public; Owner: abel
--

CREATE TABLE public.enderecos_clientes (
    id integer NOT NULL,
    cliente_cpf public.cpf_valido,
    tipo character varying(11) NOT NULL,
    estado character(2),
    cidade character varying(28),
    barro character varying(30),
    rua character varying(30),
    numero integer,
    CONSTRAINT enderecos_clientes_estado_check CHECK ((char_length(estado) = 2))
);


ALTER TABLE public.enderecos_clientes OWNER TO abel;

--
-- Name: enderecos_clientes_id_seq; Type: SEQUENCE; Schema: public; Owner: abel
--

CREATE SEQUENCE public.enderecos_clientes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.enderecos_clientes_id_seq OWNER TO abel;

--
-- Name: enderecos_clientes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abel
--

ALTER SEQUENCE public.enderecos_clientes_id_seq OWNED BY public.enderecos_clientes.id;


--
-- Name: entregas; Type: TABLE; Schema: public; Owner: abel
--

CREATE TABLE public.entregas (
    id integer NOT NULL,
    id_endereco_entrega integer NOT NULL
);


ALTER TABLE public.entregas OWNER TO abel;

--
-- Name: entregas_id_seq; Type: SEQUENCE; Schema: public; Owner: abel
--

CREATE SEQUENCE public.entregas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.entregas_id_seq OWNER TO abel;

--
-- Name: entregas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abel
--

ALTER SEQUENCE public.entregas_id_seq OWNED BY public.entregas.id;


--
-- Name: farmacia_funcionario; Type: TABLE; Schema: public; Owner: abel
--

CREATE TABLE public.farmacia_funcionario (
    cpf_funcionario public.cpf_valido NOT NULL,
    id_farmacia integer NOT NULL
);


ALTER TABLE public.farmacia_funcionario OWNER TO abel;

--
-- Name: farmacias; Type: TABLE; Schema: public; Owner: abel
--

CREATE TABLE public.farmacias (
    id integer NOT NULL,
    estado_loc public.estados_nordeste NOT NULL,
    cidade_loc character varying(20),
    bairro_loc character varying(20),
    tipo character(1),
    gerente_cpf public.cpf_valido NOT NULL,
    gerente_funcao public.gerente_funcao_dom NOT NULL,
    CONSTRAINT farmacias_tipo_check CHECK ((tipo = ANY (ARRAY['F'::bpchar, 'S'::bpchar])))
);


ALTER TABLE public.farmacias OWNER TO abel;

--
-- Name: farmacias_id_seq; Type: SEQUENCE; Schema: public; Owner: abel
--

CREATE SEQUENCE public.farmacias_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.farmacias_id_seq OWNER TO abel;

--
-- Name: farmacias_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abel
--

ALTER SEQUENCE public.farmacias_id_seq OWNED BY public.farmacias.id;


--
-- Name: funcionarios; Type: TABLE; Schema: public; Owner: abel
--

CREATE TABLE public.funcionarios (
    cpf public.cpf_valido NOT NULL,
    nome character varying(20),
    sobrenome character varying(20),
    funcao public.funcionarios_funcao_dom NOT NULL
);


ALTER TABLE public.funcionarios OWNER TO abel;

--
-- Name: medicamentos; Type: TABLE; Schema: public; Owner: abel
--

CREATE TABLE public.medicamentos (
    id integer NOT NULL,
    restricao_de_venda boolean NOT NULL
);


ALTER TABLE public.medicamentos OWNER TO abel;

--
-- Name: medicamentos_id_seq; Type: SEQUENCE; Schema: public; Owner: abel
--

CREATE SEQUENCE public.medicamentos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.medicamentos_id_seq OWNER TO abel;

--
-- Name: medicamentos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abel
--

ALTER SEQUENCE public.medicamentos_id_seq OWNED BY public.medicamentos.id;


--
-- Name: vendas; Type: TABLE; Schema: public; Owner: abel
--

CREATE TABLE public.vendas (
    id integer NOT NULL,
    id_remedio integer NOT NULL,
    cpf_cliente character(11),
    cpf_vendedor public.cpf_valido,
    funcao_vendedor public.funcionarios_funcao_dom,
    uso_de_receita boolean NOT NULL,
    id_entrega integer,
    CONSTRAINT receita_cliente_cadastrado CHECK (((uso_de_receita = false) OR (cpf_cliente IS NOT NULL))),
    CONSTRAINT so_entrega_para_cli_cadas CHECK (((id_entrega IS NULL) OR (cpf_cliente IS NOT NULL))),
    CONSTRAINT so_vendedor_vende CHECK (((funcao_vendedor)::text = 'vendedor'::text))
);


ALTER TABLE public.vendas OWNER TO abel;

--
-- Name: vendas_id_seq; Type: SEQUENCE; Schema: public; Owner: abel
--

CREATE SEQUENCE public.vendas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vendas_id_seq OWNER TO abel;

--
-- Name: vendas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abel
--

ALTER SEQUENCE public.vendas_id_seq OWNED BY public.vendas.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: abel
--

ALTER TABLE ONLY public.enderecos_clientes ALTER COLUMN id SET DEFAULT nextval('public.enderecos_clientes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: abel
--

ALTER TABLE ONLY public.entregas ALTER COLUMN id SET DEFAULT nextval('public.entregas_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: abel
--

ALTER TABLE ONLY public.farmacias ALTER COLUMN id SET DEFAULT nextval('public.farmacias_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: abel
--

ALTER TABLE ONLY public.medicamentos ALTER COLUMN id SET DEFAULT nextval('public.medicamentos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: abel
--

ALTER TABLE ONLY public.vendas ALTER COLUMN id SET DEFAULT nextval('public.vendas_id_seq'::regclass);


--
-- Data for Name: clientes; Type: TABLE DATA; Schema: public; Owner: abel
--



--
-- Data for Name: enderecos_clientes; Type: TABLE DATA; Schema: public; Owner: abel
--



--
-- Name: enderecos_clientes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abel
--

SELECT pg_catalog.setval('public.enderecos_clientes_id_seq', 1, false);


--
-- Data for Name: entregas; Type: TABLE DATA; Schema: public; Owner: abel
--



--
-- Name: entregas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abel
--

SELECT pg_catalog.setval('public.entregas_id_seq', 1, false);


--
-- Data for Name: farmacia_funcionario; Type: TABLE DATA; Schema: public; Owner: abel
--



--
-- Data for Name: farmacias; Type: TABLE DATA; Schema: public; Owner: abel
--



--
-- Name: farmacias_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abel
--

SELECT pg_catalog.setval('public.farmacias_id_seq', 1, false);


--
-- Data for Name: funcionarios; Type: TABLE DATA; Schema: public; Owner: abel
--



--
-- Data for Name: medicamentos; Type: TABLE DATA; Schema: public; Owner: abel
--



--
-- Name: medicamentos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abel
--

SELECT pg_catalog.setval('public.medicamentos_id_seq', 1, false);


--
-- Data for Name: vendas; Type: TABLE DATA; Schema: public; Owner: abel
--



--
-- Name: vendas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abel
--

SELECT pg_catalog.setval('public.vendas_id_seq', 1, false);


--
-- Name: clientes_pkey; Type: CONSTRAINT; Schema: public; Owner: abel
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_pkey PRIMARY KEY (cpf);


--
-- Name: enderecos_clientes_pkey; Type: CONSTRAINT; Schema: public; Owner: abel
--

ALTER TABLE ONLY public.enderecos_clientes
    ADD CONSTRAINT enderecos_clientes_pkey PRIMARY KEY (id);


--
-- Name: entregas_pkey; Type: CONSTRAINT; Schema: public; Owner: abel
--

ALTER TABLE ONLY public.entregas
    ADD CONSTRAINT entregas_pkey PRIMARY KEY (id);


--
-- Name: farmacia_funcionario_cpf_funcionario_key; Type: CONSTRAINT; Schema: public; Owner: abel
--

ALTER TABLE ONLY public.farmacia_funcionario
    ADD CONSTRAINT farmacia_funcionario_cpf_funcionario_key UNIQUE (cpf_funcionario);


--
-- Name: farmacia_funcionario_pkey; Type: CONSTRAINT; Schema: public; Owner: abel
--

ALTER TABLE ONLY public.farmacia_funcionario
    ADD CONSTRAINT farmacia_funcionario_pkey PRIMARY KEY (cpf_funcionario, id_farmacia);


--
-- Name: farmacias_pkey; Type: CONSTRAINT; Schema: public; Owner: abel
--

ALTER TABLE ONLY public.farmacias
    ADD CONSTRAINT farmacias_pkey PRIMARY KEY (id);


--
-- Name: funcionarios_cpf_key; Type: CONSTRAINT; Schema: public; Owner: abel
--

ALTER TABLE ONLY public.funcionarios
    ADD CONSTRAINT funcionarios_cpf_key UNIQUE (cpf);


--
-- Name: funcionarios_pkey; Type: CONSTRAINT; Schema: public; Owner: abel
--

ALTER TABLE ONLY public.funcionarios
    ADD CONSTRAINT funcionarios_pkey PRIMARY KEY (cpf, funcao);


--
-- Name: medicamentos_id_key; Type: CONSTRAINT; Schema: public; Owner: abel
--

ALTER TABLE ONLY public.medicamentos
    ADD CONSTRAINT medicamentos_id_key UNIQUE (id);


--
-- Name: medicamentos_pkey; Type: CONSTRAINT; Schema: public; Owner: abel
--

ALTER TABLE ONLY public.medicamentos
    ADD CONSTRAINT medicamentos_pkey PRIMARY KEY (id, restricao_de_venda);


--
-- Name: unica_farmacia_por_bairro; Type: CONSTRAINT; Schema: public; Owner: abel
--

ALTER TABLE ONLY public.farmacias
    ADD CONSTRAINT unica_farmacia_por_bairro EXCLUDE USING gist (bairro_loc WITH =, cidade_loc WITH =, estado_loc WITH =);


--
-- Name: unica_sede; Type: CONSTRAINT; Schema: public; Owner: abel
--

ALTER TABLE ONLY public.farmacias
    ADD CONSTRAINT unica_sede EXCLUDE USING gist (tipo WITH =) WHERE ((tipo = 'S'::bpchar));


--
-- Name: vendas_pkey; Type: CONSTRAINT; Schema: public; Owner: abel
--

ALTER TABLE ONLY public.vendas
    ADD CONSTRAINT vendas_pkey PRIMARY KEY (id);


--
-- Name: enderecos_clientes_cliente_cpf_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abel
--

ALTER TABLE ONLY public.enderecos_clientes
    ADD CONSTRAINT enderecos_clientes_cliente_cpf_fkey FOREIGN KEY (cliente_cpf) REFERENCES public.clientes(cpf);


--
-- Name: entregas_id_endereco_entrega_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abel
--

ALTER TABLE ONLY public.entregas
    ADD CONSTRAINT entregas_id_endereco_entrega_fkey FOREIGN KEY (id_endereco_entrega) REFERENCES public.enderecos_clientes(id);


--
-- Name: farmacia_funcionario_cpf_funcionario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abel
--

ALTER TABLE ONLY public.farmacia_funcionario
    ADD CONSTRAINT farmacia_funcionario_cpf_funcionario_fkey FOREIGN KEY (cpf_funcionario) REFERENCES public.funcionarios(cpf);


--
-- Name: farmacia_funcionario_id_farmacia_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abel
--

ALTER TABLE ONLY public.farmacia_funcionario
    ADD CONSTRAINT farmacia_funcionario_id_farmacia_fkey FOREIGN KEY (id_farmacia) REFERENCES public.farmacias(id);


--
-- Name: funcionarios_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abel
--

ALTER TABLE ONLY public.farmacias
    ADD CONSTRAINT funcionarios_fkey FOREIGN KEY (gerente_cpf, gerente_funcao) REFERENCES public.funcionarios(cpf, funcao);


--
-- Name: funcionarios_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abel
--

ALTER TABLE ONLY public.vendas
    ADD CONSTRAINT funcionarios_fkey FOREIGN KEY (cpf_vendedor, funcao_vendedor) REFERENCES public.funcionarios(cpf, funcao);


--
-- Name: medicamentos_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abel
--

ALTER TABLE ONLY public.vendas
    ADD CONSTRAINT medicamentos_fkey FOREIGN KEY (id_remedio, uso_de_receita) REFERENCES public.medicamentos(id, restricao_de_venda);


--
-- Name: vendas_cpf_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abel
--

ALTER TABLE ONLY public.vendas
    ADD CONSTRAINT vendas_cpf_cliente_fkey FOREIGN KEY (cpf_cliente) REFERENCES public.clientes(cpf);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

-- Testes
-- Inserindo funcionarios

INSERT INTO funcionarios (cpf, nome, sobrenome, funcao) VALUES ('12345678911', 'Artur', 'Maia', 'vendedor');
INSERT INTO funcionarios (cpf, nome, sobrenome, funcao) VALUES ('12345678912', 'Gustavo', 'Rick', 'administrador');
INSERT INTO funcionarios (cpf, nome, sobrenome, funcao) VALUES ('12345678913', 'Riquinho', 'Rico', 'caixa');
INSERT INTO funcionarios (cpf, nome, sobrenome, funcao) VALUES ('12345678914', 'The', 'Flash', 'entregador');
INSERT INTO funcionarios (cpf, nome, sobrenome, funcao) VALUES ('12345678915', 'Raul', 'Seixas', 'farmaceutico');

-- Tentando inserir com um cpf ja cadastrado (da erro)

INSERT INTO funcionarios (cpf, nome, sobrenome, funcao) VALUES ('12345678911', 'Mario', 'Antunes', 'caixa');

-- Inserindo farmacias como sedes e filiais

INSERT INTO farmacias (estado_loc, cidade_loc, bairro_loc, tipo, gerente_cpf, gerente_funcao) VALUES ('PB', 'Campina Grande', 'Centro', 'S', '12345678912', 'administrador');

INSERT INTO farmacias (estado_loc, cidade_loc, bairro_loc, tipo, gerente_cpf, gerente_funcao) VALUES ('PB', 'Campina Grande', 'Liberdade', 'F', '12345678912', 'administrador');

INSERT INTO farmacias (estado_loc, cidade_loc, bairro_loc, tipo, gerente_cpf, gerente_funcao) VALUES ('PE', 'Recife', 'Centro', 'F', '12345678915', 'farmaceutico');

-- Tentando inserir mais de uma sede (da erro)

INSERT INTO farmacias (estado_loc, cidade_loc, bairro_loc, tipo, gerente_cpf, gerente_funcao) VALUES ('PB', 'Campina Grande', 'Bodocongo', 'S', '12345678915', 'farmaceutico');

-- Tentando inserir mais de uma farmacia em um mesmo bairro (da erro)

INSERT INTO farmacias (estado_loc, cidade_loc, bairro_loc, tipo, gerente_cpf, gerente_funcao) VALUES ('PB', 'Campina Grande', 'Centro', 'F', '12345678915', 'farmaceutico');

-- Adicionando farmacias onde funcionarios trabalham

INSERT INTO farmacia_funcionario (cpf_funcionario, id_farmacia) VALUES ('12345678912', 1);

INSERT INTO farmacia_funcionario (cpf_funcionario, id_farmacia) VALUES ('12345678911', 1);

INSERT INTO farmacia_funcionario (cpf_funcionario, id_farmacia) VALUES ('12345678914', 2);

-- Testando vendas

INSERT INTO medicamentos (restricao_de_venda) values (true);

INSERT INTO medicamentos (restricao_de_venda) values (false);

-- Compra com receita para cliente desconhecido (da erro)

INSERT INTO vendas (id_remedio, cpf_cliente, cpf_vendedor, funcao_vendedor, uso_de_receita, id_entrega) VALUES (1, null, 12345678911, 'vendedor', true, null);

-- Funcionario diferente de vendedor tentando vender (da erro)
 
INSERT INTO vendas (id_remedio, cpf_cliente, cpf_vendedor, funcao_vendedor, uso_de_receita, id_entrega) VALUES (1, null, 12345678913, 'caixa', false, null);

-- Cliente desconhecido (da erro)

INSERT INTO vendas (id_remedio, cpf_cliente, cpf_vendedor, funcao_vendedor, uso_de_receita, id_entrega) VALUES (1, 111, 12345678911, 'vendedor', true, null);

INSERT INTO vendas (id_remedio, cpf_cliente, cpf_vendedor, funcao_vendedor, uso_de_receita, id_entrega) VALUES (2, null, 12345678911, 'vendedor', false, null);