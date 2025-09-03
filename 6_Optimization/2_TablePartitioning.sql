/*
Large dataset management
*/

-- create partitioned tables
CREATE TABLE
	Artists_1986
	as SELECT
		*
	FROM
		Artists
	WHERE
		strftime('%Y', BirthDate) = '1986'
;

CREATE TABLE
	Artists_1987
	as SELECT
		*
	FROM
		Artists
	WHERE
		strftime('%Y', Birthdate) = '1987'
;

