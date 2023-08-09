drop table if exists ontology_data;
create table ontology_data(
idx integer primary key,
tag text,
sustainability_preference text,
preference_category text,
association decimal(10,4),
conditional BOOLEAN CHECK (conditional IN (0, 1))
);
drop table if exists vocabulary;
create table vocabulary(
idx integer primary key,
vocab text
);
drop table if exists product_data;
create table product_data(
source text,
idx integer,
product_code text,
product_title text,
product_description clob,
product_category text,
price decimal(10,5),
brand text,
PRIMARY KEY (source, idx)
);
drop table if exists product_keywords;
create table product_keywords(
source text not null,
product_idx integer not null,
vocab_idx integer,
PRIMARY KEY (source, product_idx, vocab_idx),
FOREIGN KEY(source, product_idx) 
	REFERENCES product_data(source, product_idx)
         ON DELETE CASCADE 
         ON UPDATE NO ACTION,
FOREIGN KEY(vocab_idx) 
	REFERENCES vocabulary(vocab_idx)
         ON DELETE CASCADE 
         ON UPDATE NO ACTION
);
/*
drop table if exists green_product_sustainability_mapping;
create table sustainability_mapping(
source text not null,
product_idx integer not null,
environment float,
health float,
quality float,
social float,
PRIMARY KEY (source, product_idx)
FOREIGN KEY(source, product_idx) 
	REFERENCES product_data(source, product_idx)
         ON DELETE CASCADE 
         ON UPDATE NO ACTION
); */
drop table if exists product_ontology_mapping;
create table product_ontology_mapping(
source text not null,
product_idx integer not null,
onto_idx integer not null,
imp_score decimal(10,4),
PRIMARY KEY (source, product_idx, onto_idx),
FOREIGN KEY(source, product_idx) 
	REFERENCES product_data(source, product_idx)
         ON DELETE CASCADE 
         ON UPDATE NO ACTION,
FOREIGN KEY(onto_idx) 
	REFERENCES ontology_data(onto_idx)
         ON DELETE CASCADE 
         ON UPDATE NO ACTION
);