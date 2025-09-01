-- Load step
PRAGMA foreign_keys = OFF;

INSERT INTO
	Genres(GenreID, Name)
SELECT
	GenreID,
	Name
FROM
	GenresCleaned
;

INSERT INTO
	Artists(ArtistID, Name, BirthDate, GenreID)
SELECT
	ArtistID,
	Name,
	BirthDate,
	GenreID
FROM
	ArtistsCleaned
;

INSERT INTO
	Albums(AlbumID, Title, ReleaseDate, ArtistID)
SELECT
	AlbumID,
	Title,
	ReleaseDate,
	ArtistID
FROM
	AlbumsCleaned
;

INSERT INTO
	Tracks(TrackID, Title, Duration, AlbumID)
SELECT
	TrackID,
	Title,
	Duration,
	AlbumID
FROM
	TracksCleaned
WHERE
	Duration > 0
;

PRAGMA foreign_keys = ON;

-- Cleanup
DROP TABLE if EXISTS ArtistsTemp;
DROP TABLE if EXISTS AlbumsTemp;
DROP TABLE if EXISTS TracksTemp;
DROP TABLE if EXISTS GenresTemp;

DROP TABLE if EXISTS ArtistsCleaned;
DROP TABLE if EXISTS AlbumsCleaned;
DROP TABLE if EXISTS TracksCleaned;
DROP TABLE if EXISTS GenresCleaned;

