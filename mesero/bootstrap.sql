CREATE TABLE
  IF NOT EXISTS directors (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(64),
    dob smallint,
    dod smallint,
    picture BLOB
  );

CREATE TABLE
  IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username VARCHAR(64),
    password TEXT,
    profile_picture BLOB
  );

CREATE TABLE
  IF NOT EXISTS "studios" (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(64),
    founded_in smallint,
    picture BLOB
  );

CREATE TABLE
  IF NOT EXISTS movies (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    studio INTEGER,
    director INTEGER,
    "year" SMALLINT,
    name TEXT,
    cover BLOB,
    CONSTRAINT movies_FK FOREIGN KEY (studio) REFERENCES studios (id),
    CONSTRAINT movies_FK_1 FOREIGN KEY (director) REFERENCES directors (id)
  );

CREATE TABLE
  IF NOT EXISTS movies (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    studio INTEGER,
    director INTEGER,
    "year" SMALLINT,
    name TEXT,
    cover BLOB,
    CONSTRAINT movies_FK FOREIGN KEY (studio) REFERENCES studios (id),
    CONSTRAINT movies_FK_1 FOREIGN KEY (director) REFERENCES directors (id)
  );
