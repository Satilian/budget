-- +goose Up
-- +goose StatementBegin
CREATE TABLE public.users (
	id uuid DEFAULT uuid_generate_v4() NOT NULL,
	login varchar NOT NULL,
	email varchar NOT NULL,
	password varchar NOT NULL,
	created_at timestamp DEFAULT NOW() NOT NULL,
	updated_at timestamp,
	deleted_at timestamp,
	CONSTRAINT users_pk PRIMARY KEY (id),
	CONSTRAINT users_unique UNIQUE (login)
);

CREATE TABLE public.categories (
	id uuid DEFAULT uuid_generate_v4() NOT NULL,
	name varchar NOT NULL,
	CONSTRAINT categories_pk PRIMARY KEY (id),
	CONSTRAINT categories_unique UNIQUE (name)
);

CREATE TABLE public.expense (
	id uuid DEFAULT uuid_generate_v4() NOT NULL,
	name varchar NOT NULL,
	value decimal NOT NULL,
	userId uuid NOT NULL,
	categoryId uuid NOT NULL,
	CONSTRAINT expense_pk PRIMARY KEY (id),
	CONSTRAINT expense_unique UNIQUE (name),
 	CONSTRAINT expense_users_fk FOREIGN KEY (userId) REFERENCES public.users(id),
	CONSTRAINT expense_categories_fk FOREIGN KEY (categoryId) REFERENCES public.categories(id)
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE public.expense;
DROP TABLE public.categories;
DROP TABLE public.users;
-- +goose StatementEnd
