/*
Implement the normalized schema
*/

-- Remove transitive dependency on ArtistGenre.
CREATE TABLE Tracks_New(
	TrackID INTEGER PRIMARY KEY,
	Title TEXT NOT NULL,
	Duration INTEGER,
	AlbumID INTEGER,
	FOREIGN KEY (AlbumID) REFERENCES Albums(AlbumID),
	CHECK(Title is NOT NULL)
);

DROP TABLE Tracks;

ALTER TABLE Tracks_New RENAME to Tracks;

CREATE INDEX idx_track_title on Tracks(Title);