-- Transform step
-- Albums table

-- Ensure ArtistID in AlbumsTemp is valid
DELETE FROM 
	AlbumsTemp
WHERE
	ArtistID
NOT in (
	SELECT
		ArtistID
	FROM
		ArtistsTemp
	)
;

CREATE TABLE
	AlbumsCleaned
as SELECT
	*
FROM
	AlbumsTemp
;

DELETE FROM
	AlbumsCleaned
WHERE
	Title is NULL or Title = ''
;

DELETE FROM
	AlbumsCleaned
WHERE
	rowid NOT in (
	SELECT
		min(rowid)
	FROM
		AlbumsCleaned
	GROUP by
		AlbumID
	)
;

UPDATE
	AlbumsCleaned
SET
	Title = trim(Title)
;

-- Ensure ArtistID in AlbumsCleaned is valid (post - transformation validation)
DELETE FROM
	AlbumsCleaned
WHERE
	ArtistID
NOT in (
	SELECT
		ArtistID
	FROM
		ArtistsCleaned
	)
;