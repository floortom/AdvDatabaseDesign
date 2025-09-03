/*
Large dataset management
*/

-- use views
CREATE VIEW
	All_Artists as
	SELECT
		*
	FROM
		Artists_1986
	UNION ALL
	SELECT
		*
	FROM
		Artists_1987
;

CREATE VIEW
	Popular_Artists as
	SELECT
		Name,
		count(Albums.AlbumID) as AlbumCount
	FROM
		Artists
		INNER JOIN
			Albums
			on Artists.ArtistID = Albums.ArtistID
	GROUP by
		Artists.Name
;