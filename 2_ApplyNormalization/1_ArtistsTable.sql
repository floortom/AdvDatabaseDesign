/*
Implement the normalized schema
*/

-- Create a new table with a correctly implemented GenreID column
CREATE TABLE Artists_New(
	ArtistID INTEGER PRIMARY KEY,
	Name TEXT NOT NULL,
	BirthDate date NOT NULL,
	GenreID INTEGER,
	FOREIGN KEY (GenreID) REFERENCES Genres(GenreID)
);

-- Drop the original table
DROP TABLE Artists;

-- Rename the new table to the original table name
ALTER TABLE Artists_New RENAME to Artists;

-- Create index on GenreID
CREATE INDEX idx_artist_genre on Artists(GenreID);