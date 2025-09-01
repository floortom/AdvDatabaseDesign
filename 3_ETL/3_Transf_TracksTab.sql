-- Transform step
-- Tracks table
CREATE TABLE 
	TracksCleaned
as SELECT
	*
FROM
	TracksTemp
;

DELETE FROM
	TracksCleaned
WHERE
	Title is NULL or Title = ''
;

-- convert duration to secs
UPDATE
	TracksCleaned
SET
	Duration = Duration * 60
;

DELETE FROM
	TracksCleaned
WHERE
	Duration <= 0
;

-- Ensure AlbumID in TracksCleaned is valid (post - transformation validation)
DELETE FROM
	TracksCleaned
WHERE
	AlbumID NOT in (
	SELECT
		AlbumID
	FROM
		AlbumsCleaned
	)
;