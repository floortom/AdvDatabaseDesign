/*
Large dataset management
*/

-- batch processing
UPDATE
	Tracks
SET
	Duration = Duration + 1
WHERE
	TrackID BETWEEN 1 AND 30
;

UPDATE
	Tracks
SET
	Duration = Duration + 1
WHERE
	TrackID BETWEEN 31 AND 60
;

--  parallell execution (typically handled by application logic)
PRAGMA synchronous = OFF;