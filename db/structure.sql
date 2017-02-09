CREATE TABLE "schema_migrations" ("version" varchar NOT NULL PRIMARY KEY);
CREATE TABLE "ar_internal_metadata" ("key" varchar NOT NULL PRIMARY KEY, "value" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "comments" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_name" varchar, "comment" text, "date_time" datetime, "product_id" integer);
CREATE TABLE "order_statuses" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "order_items" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "product_id" integer, "order_id" integer, "unit_price" float, "amount" integer, "total_price" float, "size" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE INDEX "index_order_items_on_product_id" ON "order_items" ("product_id");
CREATE INDEX "index_order_items_on_order_id" ON "order_items" ("order_id");
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_name" varchar, "salt" varchar, "password_hash" varchar, "email" varchar, "admin" boolean, "status" varchar);
CREATE TABLE "products" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "product_name" varchar, "description" text, "price" float, "product_id" integer, "size_min" float, "size_max" float, "color" varchar, "gender" varchar, "amount" integer, "category" varchar, "type" varchar);
CREATE TABLE "orders" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "subtotal" float, "shipping" float, "total" float, "order_status_id" integer, "user_name" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "address" text);
CREATE INDEX "index_orders_on_order_status_id" ON "orders" ("order_status_id");
INSERT INTO schema_migrations (version) VALUES
('20170125164853'),
('20170128180338'),
('20170128190821'),
('20170128214657'),
('20170202091501'),
('20170202094724'),
('20170202095837'),
('20170202115041'),
('20170202115717'),
('20170202125947'),
('20170202220308'),
('20170203001129'),
('20170203094250'),
('20170203100111'),
('20170203105144'),
('20170203111740'),
('20170203113852'),
('20170203132733'),
('20170203140240'),
('20170203155628'),
('20170203161241'),
('20170204145337'),
('20170205164322'),
('20170205165031');


