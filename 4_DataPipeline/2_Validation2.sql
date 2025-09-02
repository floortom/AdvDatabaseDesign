/*
Validation techniques
*/

-- 2. Validate foreign key references
SELECT
	*
FROM	
	Albums
WHERE
	ArtistID
	NOT in(
	SELECT
		ArtistID
	FROM
		Artists
	)
;
	
-- 3. Validate artist birth date
SELECT
	*
FROM
	Artists
WHERE
	BirthDate > date('now')
;

-- add a new columns
ALTER TABLE
	Artists
ADD COLUMN 
	BirthDateFormatted date
;

-- 	Update the new column with proper date conversion
UPDATE Artists
SET BirthDateFormatted = 
  CASE
    WHEN length(BirthDate) > 0 THEN
      CASE
        WHEN CAST(substr(BirthDate, -2) AS INTEGER) < 24 THEN
          '20' || substr(BirthDate, -2) || '-' ||
          substr('0' || substr(BirthDate, 1, instr(BirthDate, '/') - 1), -2) || '-' ||
          substr('0' || substr(BirthDate, instr(BirthDate, '/') + 1, instr(substr(BirthDate, instr(BirthDate, '/') + 1), '/') - 1), -2)
        ELSE
          '19' || substr(BirthDate, -2) || '-' ||
          substr('0' || substr(BirthDate, 1, instr(BirthDate, '/') - 1), -2) || '-' ||
          substr('0' || substr(BirthDate, instr(BirthDate, '/') + 1, instr(substr(BirthDate, instr(BirthDate, '/') + 1), '/') - 1), -2)
      END
    ELSE NULL
  END
WHERE BirthDate IS NOT NULL
;

-- Update null dates to a default value
UPDATE
	Artists
SET
	BirthDateFormatted = '999-12-31'
WHERE
	BirthDateFormatted is NULL
;

-- verify the updated date
SELECT 
	BirthDate, BirthDateFormatted
FROM
	Artists
WHERE
	BirthDateFormatted is NULL
;

-- Manually fix remaining problematic dates
UPDATE
	Artists
SET
	BirthDateFormatted = 'YYYY-MM-DD'
WHERE
	BirthDate = 'MM/DD/YY'
;

-- Replace the old column
CREATE TABLE ArtistsNew(
	ArtistID PRIMARY KEY,
	Name TEXT not NULL,
	BirthDate date not NULL,
	GenreID INTEGER,
	FOREIGN KEY (GenreID) REFERENCES Genres(GenreID)
);


SELECT DISTINCT
	GenreID
FROM
	Artists
WHERE 
	GenreID NOT IN(
	SELECT
		GenreID
	FROM
		Genres
	)
;


INSERT INTO 
	ArtistsNew (ArtistID, Name, BirthDate, GenreID)
SELECT DISTINCT 
	ArtistID, Name, BirthDateFormatted, GenreID
FROM
	Artists
WHERE 
	GenreID IN(
	SELECT
		GenreID
	FROM
		Genres
	)
;

PRAGMA foreign_keys = OFF;
DROP TABLE Artists;
PRAGMA foreign_keys = ON;
ALTER TABLE
	ArtistsNew
RENAME to
	Artists
;

CREATE INDEX idx_artist_name on Artists(Name);

SELECT
	*
FROM
	Artists
WHERE
	BirthDate > date('now')
;