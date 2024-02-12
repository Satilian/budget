-- +goose Up
-- +goose StatementBegin
CREATE TABLE public.users (
	id uuid DEFAULT uuid_generate_v4() NOT NULL,
	login varchar NOT NULL,
	email varchar NOT NULL,
	password varchar NOT NULL,
	created_at time DEFAULT NOW() NOT NULL,
	updated_at time,
	deleted_at time,
	CONSTRAINT users_pk PRIMARY KEY (id),
	CONSTRAINT users_unique UNIQUE (login)
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE public.users;
-- +goose StatementEnd
