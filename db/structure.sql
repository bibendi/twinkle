--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.11
-- Dumped by pg_dump version 9.6.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: transport_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE transport_type AS ENUM (
    'Transports::Telegram'
);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: channel_transports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE channel_transports (
    id integer NOT NULL,
    channel_id integer NOT NULL,
    transport_id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: channel_transports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE channel_transports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: channel_transports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE channel_transports_id_seq OWNED BY channel_transports.id;


--
-- Name: channels; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE channels (
    id integer NOT NULL,
    client_id integer NOT NULL,
    name character varying NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: channels_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE channels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: channels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE channels_id_seq OWNED BY channels.id;


--
-- Name: client_teams; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE client_teams (
    id integer NOT NULL,
    client_id integer NOT NULL,
    team_id integer NOT NULL,
    role_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: client_teams_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE client_teams_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: client_teams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE client_teams_id_seq OWNED BY client_teams.id;


--
-- Name: client_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE client_users (
    id integer NOT NULL,
    client_id integer NOT NULL,
    user_id integer NOT NULL,
    role_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: client_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE client_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: client_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE client_users_id_seq OWNED BY client_users.id;


--
-- Name: clients; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE clients (
    id integer NOT NULL,
    name character varying NOT NULL,
    token character varying NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: clients_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE clients_id_seq OWNED BY clients.id;


--
-- Name: orgs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE orgs (
    id integer NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: orgs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE orgs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: orgs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE orgs_id_seq OWNED BY orgs.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: teams; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE teams (
    id integer NOT NULL,
    org_id integer NOT NULL,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: teams_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE teams_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: teams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE teams_id_seq OWNED BY teams.id;


--
-- Name: transports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE transports (
    id integer NOT NULL,
    type transport_type NOT NULL,
    client_id integer NOT NULL,
    data jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: transports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE transports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: transports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE transports_id_seq OWNED BY transports.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying NOT NULL,
    username character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    role_id integer NOT NULL,
    github_token character varying NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: channel_transports id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY channel_transports ALTER COLUMN id SET DEFAULT nextval('channel_transports_id_seq'::regclass);


--
-- Name: channels id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY channels ALTER COLUMN id SET DEFAULT nextval('channels_id_seq'::regclass);


--
-- Name: client_teams id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY client_teams ALTER COLUMN id SET DEFAULT nextval('client_teams_id_seq'::regclass);


--
-- Name: client_users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY client_users ALTER COLUMN id SET DEFAULT nextval('client_users_id_seq'::regclass);


--
-- Name: clients id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY clients ALTER COLUMN id SET DEFAULT nextval('clients_id_seq'::regclass);


--
-- Name: orgs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY orgs ALTER COLUMN id SET DEFAULT nextval('orgs_id_seq'::regclass);


--
-- Name: teams id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY teams ALTER COLUMN id SET DEFAULT nextval('teams_id_seq'::regclass);


--
-- Name: transports id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY transports ALTER COLUMN id SET DEFAULT nextval('transports_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: channel_transports channel_transports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY channel_transports
    ADD CONSTRAINT channel_transports_pkey PRIMARY KEY (id);


--
-- Name: channels channels_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY channels
    ADD CONSTRAINT channels_pkey PRIMARY KEY (id);


--
-- Name: client_teams client_teams_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY client_teams
    ADD CONSTRAINT client_teams_pkey PRIMARY KEY (id);


--
-- Name: client_users client_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY client_users
    ADD CONSTRAINT client_users_pkey PRIMARY KEY (id);


--
-- Name: clients clients_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: orgs orgs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY orgs
    ADD CONSTRAINT orgs_pkey PRIMARY KEY (id);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- Name: transports transports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY transports
    ADD CONSTRAINT transports_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_channel_transports_on_channel_id_and_transport_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_channel_transports_on_channel_id_and_transport_id ON channel_transports USING btree (channel_id, transport_id);


--
-- Name: index_channel_transports_on_transport_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_channel_transports_on_transport_id ON channel_transports USING btree (transport_id);


--
-- Name: index_channels_on_client_id_and_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_channels_on_client_id_and_name ON channels USING btree (client_id, name);


--
-- Name: index_client_teams_on_client_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_client_teams_on_client_id ON client_teams USING btree (client_id);


--
-- Name: index_client_teams_on_team_id_and_client_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_client_teams_on_team_id_and_client_id ON client_teams USING btree (team_id, client_id);


--
-- Name: index_client_users_on_client_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_client_users_on_client_id ON client_users USING btree (client_id);


--
-- Name: index_client_users_on_user_id_and_client_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_client_users_on_user_id_and_client_id ON client_users USING btree (user_id, client_id);


--
-- Name: index_clients_on_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_clients_on_token ON clients USING btree (token);


--
-- Name: index_orgs_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_orgs_on_name ON orgs USING btree (name);


--
-- Name: index_teams_on_org_id_and_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_teams_on_org_id_and_name ON teams USING btree (org_id, name);


--
-- Name: index_transports_on_client_id_and_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_transports_on_client_id_and_type ON transports USING btree (client_id, type);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_username; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_username ON users USING btree (username);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: client_teams fk_rails_0cb8c07097; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY client_teams
    ADD CONSTRAINT fk_rails_0cb8c07097 FOREIGN KEY (team_id) REFERENCES teams(id) ON DELETE CASCADE;


--
-- Name: client_teams fk_rails_16800be0e2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY client_teams
    ADD CONSTRAINT fk_rails_16800be0e2 FOREIGN KEY (client_id) REFERENCES clients(id) ON DELETE CASCADE;


--
-- Name: channel_transports fk_rails_5e6b964f7c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY channel_transports
    ADD CONSTRAINT fk_rails_5e6b964f7c FOREIGN KEY (transport_id) REFERENCES transports(id) ON DELETE CASCADE;


--
-- Name: transports fk_rails_8157cb1789; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY transports
    ADD CONSTRAINT fk_rails_8157cb1789 FOREIGN KEY (client_id) REFERENCES clients(id) ON DELETE CASCADE;


--
-- Name: client_users fk_rails_91818ac2d3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY client_users
    ADD CONSTRAINT fk_rails_91818ac2d3 FOREIGN KEY (client_id) REFERENCES clients(id) ON DELETE CASCADE;


--
-- Name: channel_transports fk_rails_91a8ed416e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY channel_transports
    ADD CONSTRAINT fk_rails_91a8ed416e FOREIGN KEY (channel_id) REFERENCES channels(id) ON DELETE CASCADE;


--
-- Name: client_users fk_rails_d0a2432aad; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY client_users
    ADD CONSTRAINT fk_rails_d0a2432aad FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE;


--
-- Name: teams fk_rails_d539eaab01; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY teams
    ADD CONSTRAINT fk_rails_d539eaab01 FOREIGN KEY (org_id) REFERENCES orgs(id) ON DELETE CASCADE;


--
-- Name: channels fk_rails_e3493648f1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY channels
    ADD CONSTRAINT fk_rails_e3493648f1 FOREIGN KEY (client_id) REFERENCES clients(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20160323125250');

INSERT INTO schema_migrations (version) VALUES ('20160323130931');

INSERT INTO schema_migrations (version) VALUES ('20160323162711');

INSERT INTO schema_migrations (version) VALUES ('20160323163104');

INSERT INTO schema_migrations (version) VALUES ('20161115120628');

INSERT INTO schema_migrations (version) VALUES ('20161115122352');

INSERT INTO schema_migrations (version) VALUES ('20161127182423');

INSERT INTO schema_migrations (version) VALUES ('20170416181652');

INSERT INTO schema_migrations (version) VALUES ('20170501100619');

INSERT INTO schema_migrations (version) VALUES ('20170501101937');

INSERT INTO schema_migrations (version) VALUES ('20170508102952');

INSERT INTO schema_migrations (version) VALUES ('20170508171334');

