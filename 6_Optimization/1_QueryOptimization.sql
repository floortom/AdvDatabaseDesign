/*
Optimization
*/

-- identify slow-performing queries
EXPLAIN QUERY PLAN
	SELECT
		*
	FROM
		Tracks
	WHERE
		Duration > 1000
;

-- Create index to speed up queries
CREATE INDEX idx_duration on Tracks(Duration);

EXPLAIN QUERY PLAN
	SELECT
		*
	FROM
		Tracks
	WHERE
		Duration > 1000
;
