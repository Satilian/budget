-- +goose Up
-- +goose StatementBegin
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE public.accounts (
	id uuid DEFAULT uuid_generate_v4() NOT NULL,
	email varchar NOT NULL,
	active bool DEFAULT false NOT NULL,
	created_at timestamp DEFAULT NOW() NOT NULL,
	updated_at timestamp,
	deleted_at timestamp,
	CONSTRAINT accounts_pk PRIMARY KEY (id),
	CONSTRAINT accounts_unique UNIQUE (email)
);

CREATE TABLE public.users (
	id uuid DEFAULT uuid_generate_v4() NOT NULL,
	accountId uuid NOT NULL,
	login varchar NOT NULL,
	password varchar NOT NULL,
	active bool DEFAULT false NOT NULL,
	created_at timestamp DEFAULT NOW() NOT NULL,
	updated_at timestamp,
	deleted_at timestamp,
	CONSTRAINT users_pk PRIMARY KEY (id),
	CONSTRAINT users_unique UNIQUE (login),
 	CONSTRAINT users_accaunts FOREIGN KEY (accountId) REFERENCES public.accounts(id)
);

CREATE TABLE public.categories (
	id uuid DEFAULT uuid_generate_v4() NOT NULL,
	name varchar NOT NULL,
	accountId uuid NOT NULL,
	created_at timestamp DEFAULT NOW() NOT NULL,
	updated_at timestamp,
	deleted_at timestamp,
	CONSTRAINT categories_pk PRIMARY KEY (id),
	CONSTRAINT categories_unique UNIQUE (name),
 	CONSTRAINT categories_accaunts FOREIGN KEY (accountId) REFERENCES public.accounts(id)
);

CREATE TABLE public.expense_names (
	id uuid DEFAULT uuid_generate_v4() NOT NULL,
	name varchar NOT NULL,
	accountId uuid NOT NULL,
	created_at timestamp DEFAULT NOW() NOT NULL,
	updated_at timestamp,
	deleted_at timestamp,
	CONSTRAINT expense_names_pk PRIMARY KEY (id),
	CONSTRAINT expense_names_unique UNIQUE (name),
 	CONSTRAINT expense_names_accaunts FOREIGN KEY (accountId) REFERENCES public.accounts(id)
);

CREATE TABLE public.expense (
	id uuid DEFAULT uuid_generate_v4() NOT NULL,
	value decimal NOT NULL,
	userId uuid NOT NULL,
	accountId uuid NOT NULL,
	categoryId uuid NOT NULL,
	expense_nameId uuid NOT NULL,
	created_at timestamp DEFAULT NOW() NOT NULL,
	updated_at timestamp,
	deleted_at timestamp,
	CONSTRAINT expense_pk PRIMARY KEY (id),
 	CONSTRAINT expense_users_fk FOREIGN KEY (userId) REFERENCES public.users(id),
 	CONSTRAINT expense_accaunts FOREIGN KEY (accountId) REFERENCES public.accounts(id),
	CONSTRAINT expense_categories_fk FOREIGN KEY (categoryId) REFERENCES public.categories(id),
 	CONSTRAINT expense_expense_names FOREIGN KEY (expense_nameId) REFERENCES public.expense_names(id)
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE public.expense;
DROP TABLE public.expense_names;
DROP TABLE public.categories;
DROP TABLE public.users;
DROP TABLE public.accounts;
-- +goose StatementEnd
