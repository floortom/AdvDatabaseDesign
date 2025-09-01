-- Transform step
-- Genres table
CREATE TABLE
	GenresCleaned
as SELECT
	*
FROM
	GenresTemp
;

DELETE FROM
	GenresCleaned
WHERE
	Name is NULL or Name = ''
;
	
