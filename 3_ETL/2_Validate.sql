-- validate and clean the temporary tables

-- ensure the GenreID in ArtistsTemp is valid
DELETE FROM
	ArtistsTemp
WHERE
	GenreID
	NOT in(
	SELECT
		GenreID
	FROM
		GenresTemp
	)
;

-- ensure ArtistID in AlbumsTemp is valid
DELETE FROM
	AlbumsTemp
WHERE
	ArtistID
	NOT in(
	SELECT
		ArtistID
	FROM
		ArtistsTemp
	)
;

-- ensure AlbumID in TracksTemp is valid
DELETE FROM
	TracksTemp
WHERE
	AlbumID
	NOT in(
	SELECT
		AlbumID
	FROM
		AlbumsTemp
	)
;