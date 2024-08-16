BEGIN;

CREATE TABLE IF NOT EXISTS public."SequelizeMeta"
(
    name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "SequelizeMeta_pkey" PRIMARY KEY (name)
);

CREATE TABLE IF NOT EXISTS public.categories
(
    id serial NOT NULL,
    name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    description character varying(255) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT categories_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.product_suppliers
(
    id serial NOT NULL,
    product_id integer NOT NULL,
    supplier_id integer NOT NULL,
    price double precision NOT NULL,
    CONSTRAINT product_suppliers_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.products
(
    id serial NOT NULL,
    name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    description character varying(255) COLLATE pg_catalog."default" NOT NULL,
    price numeric NOT NULL,
    category_id integer NOT NULL,
    CONSTRAINT products_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.sale_details
(
    id serial NOT NULL,
    sale_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity numeric NOT NULL,
    price numeric NOT NULL,
    CONSTRAINT sale_details_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.sales
(
    id serial NOT NULL,
    user_id integer NOT NULL,
    sale_date timestamp with time zone NOT NULL,
    total numeric NOT NULL,
    CONSTRAINT sales_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.stores
(
    id serial NOT NULL,
    name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    location character varying(255) COLLATE pg_catalog."default" NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    CONSTRAINT stores_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.suppliers
(
    id serial NOT NULL,
    name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    email character varying(255) COLLATE pg_catalog."default",
    phone character varying(255) COLLATE pg_catalog."default",
    web character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT suppliers_pkey PRIMARY KEY (id),
    CONSTRAINT suppliers_email_key UNIQUE (email)
);

CREATE TABLE IF NOT EXISTS public.users
(
    id serial NOT NULL,
    name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    email character varying(255) COLLATE pg_catalog."default" NOT NULL,
    password character varying(255) COLLATE pg_catalog."default" NOT NULL,
    role character varying(255) COLLATE pg_catalog."default" NOT NULL,
    created_at timestamp with time zone NOT NULL,
    store_id integer NOT NULL,
    avatar text COLLATE pg_catalog."default",
    CONSTRAINT users_pkey PRIMARY KEY (id),
    CONSTRAINT users_email_key UNIQUE (email)
);

CREATE TABLE IF NOT EXISTS public.warehouses
(
    id serial NOT NULL,
    product_id integer NOT NULL,
    store_id integer NOT NULL,
    quantity integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    CONSTRAINT warehouses_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.terms
(
    id integer NOT NULL,
    terms_group_id integer NOT NULL,
    term character(250)[] NOT NULL,
    icon character(250),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.terms_group
(
    id integer NOT NULL,
    name character(250)[] NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.orders
(
    id bigint NOT NULL,
    user_id integer NOT NULL,
    total double precision NOT NULL,
	id_term_order_status integer NOT NULL,
    supplier_id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.order_items
(
    order_id bigint NOT NULL,
    product_id integer NOT NULL UNIQUE,
    price double precision NOT NULL,
    CONSTRAINT order_items_pkey PRIMARY KEY (order_id, product_id),
    CONSTRAINT order_items_product_id_fkey FOREIGN KEY (product_id)
        REFERENCES public.products (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id)
        REFERENCES public.orders (id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- Constraints for existing tables
ALTER TABLE IF EXISTS public.product_suppliers
    ADD CONSTRAINT product_suppliers_product_id_fkey FOREIGN KEY (product_id)
    REFERENCES public.products (id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE SET NULL;

ALTER TABLE IF EXISTS public.product_suppliers
    ADD CONSTRAINT product_suppliers_supplier_id_fkey FOREIGN KEY (supplier_id)
    REFERENCES public.suppliers (id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE SET NULL;

ALTER TABLE IF EXISTS public.products
    ADD CONSTRAINT products_category_id_fkey FOREIGN KEY (category_id)
    REFERENCES public.categories (id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE SET NULL;

ALTER TABLE IF EXISTS public.sale_details
    ADD CONSTRAINT sale_details_product_id_fkey FOREIGN KEY (product_id)
    REFERENCES public.products (id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE SET NULL;

ALTER TABLE IF EXISTS public.sale_details
    ADD CONSTRAINT sale_details_sale_id_fkey FOREIGN KEY (sale_id)
    REFERENCES public.sales (id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE SET NULL;

ALTER TABLE IF EXISTS public.sales
    ADD CONSTRAINT sales_user_id_fkey FOREIGN KEY (user_id)
    REFERENCES public.users (id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE SET NULL;

ALTER TABLE IF EXISTS public.warehouses
    ADD CONSTRAINT warehouses_product_id_fkey FOREIGN KEY (product_id)
    REFERENCES public.products (id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE SET NULL;

ALTER TABLE IF EXISTS public.warehouses
    ADD CONSTRAINT warehouses_store_id_fkey FOREIGN KEY (store_id)
    REFERENCES public.stores (id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE SET NULL;

ALTER TABLE IF EXISTS public.terms
    ADD CONSTRAINT terms_terms_group_id_fkey FOREIGN KEY (terms_group_id)
    REFERENCES public.terms_group (id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE SET NULL;

ALTER TABLE IF EXISTS public.orders
    ADD CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id)
    REFERENCES public.users (id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE SET NULL;

ALTER TABLE IF EXISTS public.orders
    ADD CONSTRAINT orders_supplier_id_fkey FOREIGN KEY (supplier_id)
    REFERENCES public.suppliers (id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE SET NULL;

END;
