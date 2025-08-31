/*
Implement the normalized schema
*/

-- Remove redundant Genre and create foreign key relationships
CREATE TABLE Albums_New(
	AlbumID INTEGER PRIMARY KEY,
	Title TEXT NOT NULL,
	ReleaseDate date,
	ArtistID INTEGER,
	FOREIGN KEY (ArtistID) REFERENCES Artists(ArtistID),
	CHECK(Title is NOT NULL)
);

DROP TABLE Albums;

ALTER TABLE Albums_New RENAME to Albums;

CREATE INDEX idx_album_title on Albums(Title);