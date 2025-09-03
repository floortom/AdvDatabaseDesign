/*
Analytical queries
*/

SELECT * FROM Artists;

SELECT
	Name,
	GenreID
FROM
	Artists
;

SELECT * FROM Artists WHERE GenreID = 2;

SELECT * FROM Artists ORDER by Name ASC;

/*
Aggregating data
*/
SELECT
	count(*) as 'Artist Count'
FROM
	Artists
;

SELECT
	GenreID,
	count(*) as 'Number of records'
FROM
	Artists
GROUP by
	GenreID
;

SELECT
	GenreID,
	count(*) as 'Number of records'
FROM
	Artists
GROUP by
	GenreID HAVING count(*) > 5
;
	