DROP TABLE vet_specialties IF EXISTS;
DROP TABLE vets IF EXISTS;
DROP TABLE specialties IF EXISTS;
DROP TABLE visits IF EXISTS;
DROP TABLE pets IF EXISTS;
DROP TABLE types IF EXISTS;
DROP TABLE owners IF EXISTS;


CREATE TABLE vets (
  id         INTEGER IDENTITY PRIMARY KEY,
  first_name VARCHAR(30),
  last_name  VARCHAR(30)
);
CREATE INDEX vets_last_name ON vets (last_name);

CREATE TABLE specialties (
  id   INTEGER IDENTITY PRIMARY KEY,
  name VARCHAR(80)
);
CREATE INDEX specialties_name ON specialties (name);

CREATE TABLE vet_specialties (
  vet_id       INTEGER NOT NULL,
  specialty_id INTEGER NOT NULL
);
ALTER TABLE vet_specialties ADD CONSTRAINT fk_vet_specialties_vets FOREIGN KEY (vet_id) REFERENCES vets (id);
ALTER TABLE vet_specialties ADD CONSTRAINT fk_vet_specialties_specialties FOREIGN KEY (specialty_id) REFERENCES specialties (id);

CREATE TABLE available_hour (
  id   INTEGER IDENTITY PRIMARY KEY,
  time_date DATETIME
);
CREATE INDEX available_hour_time ON available_hour (time_date);

CREATE TABLE IF NOT EXISTS vet_available_hour (
  vet_id       INTEGER NOT NULL,
  available_hour_id INTEGER NOT NULL
);
ALTER TABLE vet_available_hour ADD CONSTRAINT fk_vet_available_hour_vets FOREIGN KEY (vet_id) REFERENCES vets (id);
ALTER TABLE vet_available_hour ADD CONSTRAINT fk_vet_available_hour_hours FOREIGN KEY (available_hour_id) REFERENCES available_hour (id);

CREATE TABLE types (
  id   INTEGER IDENTITY PRIMARY KEY,
  name VARCHAR(80)
);
CREATE INDEX types_name ON types (name);

CREATE TABLE owners (
  id         INTEGER IDENTITY PRIMARY KEY,
  first_name VARCHAR(30),
  last_name  VARCHAR_IGNORECASE(30),
  address    VARCHAR(255),
  city       VARCHAR(80),
  telephone  VARCHAR(20)
);
CREATE INDEX owners_last_name ON owners (last_name);

CREATE TABLE pets (
  id         INTEGER IDENTITY PRIMARY KEY,
  name       VARCHAR(30),
  birth_date DATE,
  type_id    INTEGER NOT NULL,
  owner_id   INTEGER NOT NULL
);
ALTER TABLE pets ADD CONSTRAINT fk_pets_owners FOREIGN KEY (owner_id) REFERENCES owners (id);
ALTER TABLE pets ADD CONSTRAINT fk_pets_types FOREIGN KEY (type_id) REFERENCES types (id);
CREATE INDEX pets_name ON pets (name);

CREATE TABLE visits (
  id          INTEGER IDENTITY PRIMARY KEY,
  pet_id      INTEGER NOT NULL,
  vet_id      INTEGER NOT NULL,
  visit_date  TIMESTAMP,
  description VARCHAR(255)
);
ALTER TABLE visits ADD CONSTRAINT fk_visits_pets FOREIGN KEY (pet_id) REFERENCES pets (id);
ALTER TABLE visits ADD CONSTRAINT fk_vet_visits FOREIGN KEY (vet_id) REFERENCES vets (id);
CREATE INDEX visits_pet_id ON visits (pet_id);
