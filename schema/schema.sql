-- Create database
CREATE DATABASE my_catalog;

-- Create genre table
CREATE TABLE genre (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  item_id INT NOT NULL,
  name VARCHAR(100) NOT NULL,
  FOREIGN KEY (ITEM_ID) REFERENCES ITEM(ID)
);

-- Create author table
CREATE TABLE author (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  item_id INT NOT NULL,
  FOREIGN KEY(item_id) REFERENCES item(id)
  );

-- Create label table
CREATE TABLE label (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  author VARCHAR(100) NOT NULL,
  color VARCHAR(100) NOT NULL,
  item_id INT NOT NULL,
  FOREIGN KEY(item_id) REFERENCES item(id)
);

-- Create item table
CREATE TABLE item (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  genre_id INT NOT NULL,
  author_id INT NOT NULL,
  label_id INT NOT NULL,
  published_at DATE NOT NULL,
  is_archived BOOLEAN NOT NULL,
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
  author_id INT NOT NULL,
  is_archived BOOLEAN NOT NULL,
  genre_id INT NOT NULL,
  FOREIGN KEY (author_id) REFERENCES author (id),
  FOREIGN KEY (genre_id) REFERENCES genre (id)
);

-- Create game table
CREATE TABLE game (
  id INT NOT NULL,
  multiplayer BOOLEAN NOT NULL,
  last_played_at DATE NOT NULL,
  author_id INT NOT NULL,
  genre_id INT NOT NULL,
  label_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (author_id) REFERENCES author (id),
  FOREIGN KEY (genre_id) REFERENCES genre (id),
  foreign key (author_id) references author (id)
  );

-- CREATE INDEXES
CREATE INDEX item_genre_id_idx ON item (genre_id);
CREATE INDEX item_author_id_idx ON item (author_id);
CREATE INDEX item_label_id_idx ON item (label_id);
CREATE INDEX book_item_id_idx ON book (item_id);
CREATE INDEX music_album_author_id_idx ON music_album (author_id);
CREATE INDEX music_album_genre_id_idx ON music_album (genre_id);
CREATE INDEX game_author_id_idx ON game (author_id);
CREATE INDEX game_genre_id_idx ON game (genre_id);
CREATE INDEX game_label_id_idx ON game (label_id);
