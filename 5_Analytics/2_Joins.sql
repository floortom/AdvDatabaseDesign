/*
Joins
*/

SELECT
	Artists.Name,
	Albums.Title
FROM
	Artists
	INNER JOIN Albums
	on Artists.ArtistID = Albums.ArtistID
;

-- Left join ( all values from Artists, values from Albums that do not match will be null)
SELECT
	Artists.Name,
	Albums.Title
FROM
	Artists
	LEFT JOIN Albums
	on Artists.ArtistID = Albums.ArtistID
;

SELECT
	*
FROM
	Tracks t
	LEFT JOIN Albums a
	on t.AlbumID = a.AlbumID
;