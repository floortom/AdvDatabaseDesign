/*
Validation techniques
*/

-- 1. Validate album release dates (wrong results)
SELECT
	*
FROM
	Albums
WHERE
	ReleaseDate > date('now')
;

-- CORRECT METHOD BELOW
-- Add new column
ALTER TABLE
	Albums
ADD COLUMN
	ReleaseDateFormatted date;

-- 	Update the new column with proper date conversion
UPDATE Albums
SET ReleaseDateFormatted = 
  CASE
    WHEN length(ReleaseDate) > 0 THEN
      CASE
        WHEN CAST(substr(ReleaseDate, -2) AS INTEGER) < 24 THEN
          '20' || substr(ReleaseDate, -2) || '-' ||
          substr('0' || substr(ReleaseDate, 1, instr(ReleaseDate, '/') - 1), -2) || '-' ||
          substr('0' || substr(ReleaseDate, instr(ReleaseDate, '/') + 1, instr(substr(ReleaseDate, instr(ReleaseDate, '/') + 1), '/') - 1), -2)
        ELSE
          '19' || substr(ReleaseDate, -2) || '-' ||
          substr('0' || substr(ReleaseDate, 1, instr(ReleaseDate, '/') - 1), -2) || '-' ||
          substr('0' || substr(ReleaseDate, instr(ReleaseDate, '/') + 1, instr(substr(ReleaseDate, instr(ReleaseDate, '/') + 1), '/') - 1), -2)
      END
    ELSE NULL
  END
WHERE ReleaseDate IS NOT NULL
;

-- Update null dates to a default value
UPDATE
	Albums
SET
	ReleaseDateFormatted = '9999-12-31'
WHERE
	ReleaseDateFormatted is NULL
;
					
-- Verify the updated dates
SELECT
	ReleaseDate,
	ReleaseDateFormatted
FROM
	Albums
WHERE
	ReleaseDateFormatted is NULL
;

-- Manually fix remaining problematic dates
UPDATE
	Albums
SET
	ReleaseDateFormatted = 'YYYY-MM-DD'
WHERE
	ReleaseDate = 'MM/DD/YY'
;

-- Replace the old column
CREATE TABLE AlbumsNew(
	AlbumID INTEGER PRIMARY KEY,
	Title TEXT NOT NULL,
	ReleaseDate date,
	ArtistID INTEGER,
	FOREIGN KEY (ArtistID) REFERENCES Artists(ArtistID),
	CHECK(Title is NOT NULL)
);

INSERT INTO
	AlbumsNew(AlbumID, Title, ReleaseDate, ArtistID)
SELECT DISTINCT
	AlbumID,
	Title,
	ReleaseDateFormatted,
	ArtistID
FROM
	Albums
;

PRAGMA foreign_keys = OFF;
DROP TABLE Albums;
PRAGMA foreign_keys = ON;
ALTER TABLE
	AlbumsNew
RENAME to
	Albums
;

-- Create index on album title
CREATE INDEX idx_albums on Albums(Title);	

-- verify the results	
SELECT
	*
FROM
	Albums
WHERE
	ReleaseDate > date('now')
;
	
	
	
	
	
	
	
	
	
	
	
	
	
	