-- Create database
CREATE DATABASE my_catalog;

-- Create genre table
CREATE TABLE genre (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);

-- Create author table
CREATE TABLE author (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL
);

-- Create label table
CREATE TABLE label (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  title VARCHAR(100) NOT NULL,
  color VARCHAR(100) NOT NULL,
  item_ids INT[] NOT NULL
);

-- Create item table
CREATE TABLE item (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  genre_id INT NOT NULL,
  author_id INT NOT NULL,
  label_id INT NOT NULL,
  published_at DATE NOT NULL,
  is_archived BOOLEAN NOT NULL,
  FOREIGN KEY (genre_id) REFERENCES genre (id),
  FOREIGN KEY (author_id) REFERENCES author (id),
  FOREIGN KEY (label_id) REFERENCES label (id)
);

-- Create book table (specialized form of item)
CREATE TABLE book (
  item_id INT PRIMARY KEY,
  publisher VARCHAR(100) NOT NULL,
  book_cover VARCHAR(100) NOT NULL,
  FOREIGN KEY (item_id) REFERENCES item (id)
);

-- Create music albums table
CREATE TABLE music_album (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  publish_date DATE NOT NULL DEFAULT CURRENT_DATE,
  on_spotify BOOLEAN NOT NULL,
  is_archived BOOLEAN NOT NULL,
  genre_id INT NOT NULL,
  FOREIGN KEY (genre_id) REFERENCES genre (id)
);

-- Create game table
CREATE TABLE game (
  id INT NOT NULL,
  multiplayer BOOLEAN NOT NULL,
  last_played_at DATE NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES item (id) ON DELETE CASCADE ON UPDATE CASCADE
);

--Checked UML class diagram and database and table based on UML class diagram
