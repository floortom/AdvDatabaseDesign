/*
Non-normalized schema
*/
CREATE TABLE Artists(
	ArtistID INTEGER PRIMARY KEY,
	Name TEXT NOT NULL,
	BirthDate date,
	Genre TEXT
);

CREATE TABLE Albums(
	AlbumID INTEGER PRIMARY KEY,
	Title TEXT NOT NULL,
	ReleaseDate date,
	ArtistID INTEGER,
	Genre TEXT,
	FOREIGN KEY (ArtistID) REFERENCES Artists(ArtistID)
);

CREATE TABLE Tracks(
	TrackID INTEGER PRIMARY KEY,
	Title TEXT NOT NULL,
	Duration INTEGER,
	AlbumID INTEGER,
	ArtistGenre TEXT, -- Transitive dependency
	FOREIGN KEY (AlbumID) REFERENCES Albums(AlbumID)
);

CREATE TABLE Genres(
	GenreID INTEGER PRIMARY KEY,
	Name TEXT NOT NULL
);