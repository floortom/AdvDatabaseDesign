-- Transform step
-- Artists table
CREATE TABLE
	ArtistsCleaned	
as SELECT
	*
FROM
	ArtistsTemp
;

DELETE FROM
	ArtistsCleaned
WHERE
	Name is NULL or Name = ''
;


DELETE FROM
	ArtistsCleaned
WHERE
/*
This deletes all rows except the ones whose ROWID is the minimum for their ArtistID.
In other words, it keeps one row per ArtistID and deletes the rest — effectively removing duplicates.
*/
	ROWID NOT in (
	/*
	This part groups all rows by ArtistID.
	For each group (i.e., each unique ArtistID), it selects the smallest ROWID — 
	which is typically the first inserted row for that ArtistID.
	*/
	SELECT
		min(rowid)
	FROM
		ArtistsCleaned
	GROUP by
		ArtistID
	)
;

UPDATE 
	ArtistsCleaned
SET
	Name = trim(Name)
;
