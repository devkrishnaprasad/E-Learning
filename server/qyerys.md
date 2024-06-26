# Cretae Product Category Table

CREATE TABLE product_category (
category_id SERIAL PRIMARY KEY,
category_name TEXT NOT NULL,
category_image TEXT NOT NULL,
username TEXT NOT NULL,
last_modified DATE NOT NULL,
status BOOL NOT NULL
);

# Create product details Table

CREATE TABLE product_details (
producty_id UUID PRIMARY KEY,
product_name TEXT NOT NULL,
product_image TEXT NOT NULL,
product_category TEXT NOT NULL,
price TEXT NOT NULL,
offer_price TEXT NOT NULL,
product_level TEXT NOT NULL,
rating TEXT NOT NULL,
students_count TEXT NOT NULL,
total_duration TEXT NOT NULL,
session_count TEXT NOT NULL,
about TEXT NOT NULL,
username TEXT NOT NULL,
last_modified DATE NOT NULL,
status BOOL NOT NULL
);

CREATE TABLE offer_banner_details (
banner_id UUID PRIMARY KEY,
amount DECIMAL(10, 2) NOT NULL,
title VARCHAR(255) NOT NULL,
description TEXT,
banner_image VARCHAR(255),
modified_date,
status,
modified_user
);

CREATE TABLE session_details (
session_id UUID PRIMARY KEY,
product_id UUID NOT NULL,
session_title TEXT NOT NULL,
session_duration TEXT NOT NULL,
last_modified DATE NOT NULL,
last_modified_user TEXT NOT NULL,
status BOOL NOT NULL,
FOREIGN KEY (product_id) REFERENCES product_details (product_id) ON DELETE CASCADE
);

CREATE TABLE product_review (
review_id UUID NOT NULL,
product_id UUID NOT NULL,
review_description TEXT NOT NULL,
username TEXT NOT NULL,
last_modified DATE NOT NULL
);

CREATE TABLE product_purchase_details (
product_id UUID NOT NULL,
username TEXT NOT NULL,
purchased_date DATE NOT NULL,
purchased_price TEXT NOT NULL
);
