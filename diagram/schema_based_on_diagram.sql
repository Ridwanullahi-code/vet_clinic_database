CREATE DATABASE clinic;

CREATE TABLE patients(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    date_of_birth DATE,
);

CREATE TABLE medical_histories(
	admitted_at timestamp,
	patient_id  INTEGER REFERENCES patients(id) ON DELETE CASCADE,
	status VARCHAR(250)
);

CREATE TABLE treatments(
	id SERIAL PRIMARY KEY
	type VARCHAR(255),
  name VARCHAR(255) NOT NULL,
);

CREATE TABLE invoices(
	id SERIAL PRIMARY KEY,
	tottal_amount timestamp,
	generated_at timestamp,
	payed_at timestamp,
	medical_history_id integer REFERENCES medical_histories(id) ON DELETE CASCADE
)

CREATE TABLE invoices_item(
	id SERIAL PRIMARY KEY,
	unit_price DECIMAL,
	quantity INTEGER,
	total_price DECIMAL,
	invoice_id INTEGER REFERENCES invoices(id) ON DELETE CASCADE,
	treatment_id INTEGER REFERENCES treatments(id) ON DELETE CASCADE
);

medical_histories_treatment(
	id SERIAL PRIMARY KEY,
	medical_histories_id INTEGER REFERENCES medical_histories(id) ON DELETE CASCADE,
	treatments_id INTEGER REFERENCES treatments(id) ON DELETE CASCADE
)