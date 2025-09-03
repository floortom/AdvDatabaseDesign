/*
Data Analysis
*/

-- Find top artists by the number of albums
SELECT
	Artists.Name,
	count(Albums.AlbumID) as AlbumCount
FROM
	Artists
	INNER JOIN Albums
	on Artists.ArtistID = Albums.AlbumID
GROUP by
	Artists.Name
ORDER by
	AlbumCount DESC
;

-- Identify popular genres
SELECT
	Genres.Name,
	count(*) as ArtistCount
FROM
	Artists
	INNER JOIN Genres
	on Artists.GenreID = Genres.GenreID
GROUP by
	Artists.GenreID
ORDER by 
	ArtistCount desc
;

-- Analyze the most played tracks
SELECT
	Tracks.Title,
	sum(Duration) as TotalPlays
FROM
	Tracks
GROUP by
	Tracks.Title
ORDER by
	TotalPlays DESC
;
		