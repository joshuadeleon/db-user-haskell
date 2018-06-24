-- DROP TABLE public."user"

CREATE TABLE public."user" (
	id serial NOT NULL,
	firstname text NOT NULL,
	lastname text NOT NULL,
	username text NOT NULL,
	email text NOT NULL,
	disabled bool NOT NULL DEFAULT false,
	deleted bool NOT NULL DEFAULT false,
	created timestamptz NOT NULL DEFAULT now(),
	updated timestamptz NOT NULL DEFAULT now(),
	CONSTRAINT user_email_unique UNIQUE (email),
	CONSTRAINT user_pk PRIMARY KEY (id),
	CONSTRAINT user_username_unique UNIQUE (username)
)
WITH (
	OIDS=FALSE
) ;