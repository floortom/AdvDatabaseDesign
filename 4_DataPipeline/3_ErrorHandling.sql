/*
Advanced error handling and logging
*/

-- Trigger for error handling during insert
CREATE TRIGGER error_handling_insert -- This creates a new trigger named "error_handling_insert".
BEFORE INSERT ON Albums -- The trigger will run before a new row is inserted into the Albums table.
FOR EACH ROW -- The trigger applies to each row being inserted (not just once per statement).
BEGIN -- This is the block of code that will execute when the trigger fires.
    SELECT
        CASE
            WHEN NEW.ArtistID NOT IN ( -- NEW.ArtistID refers to the ArtistID value of the row that is about to be inserted.
                SELECT ArtistID FROM Artists
            )
            THEN RAISE(ABORT, 'Invalid ArtistID') -- This aborts the insert operation and shows the message 'Invalid ArtistID'.
        END;
END;
/*
This is a great example of how triggers can be used to enforce business rules 
or custom validations that go beyond standard constraints.
*/

-- Create a log table
CREATE TABLE OperationLog(
	LogID INTEGER PRIMARY KEY,
	OperationType TEXT,
	TableName TEXT,
	RecordID INTEGER,
	Timestamp datetime DEFAULT CURRENT_TIMESTAMP
);

-- Trigger to log inserts
CREATE TRIGGER log_insert
AFTER INSERT on Artists
FOR EACH ROW
BEGIN
	INSERT INTO OperationLog(OperationType, TableName, RecordID)
	VALUES('INSERT', 'Artists', NEW.ArtistID);
END
;

/*
Test Insert Statements
*/

-- Insert a valid artist
INSERT INTO Artists(ArtistID, Name, GenreID, BirthDate)
VALUES(220, 'Pink Freud', 2, '2002-04-18');

-- Insert a valid album
INSERT INTO Albums(AlbumID, Title, ArtistID, ReleaseDate)
VALUES(150, 'Punk Freud', 220, '2015-02-25');

-- Insert an album with an invalid ArtistID
INSERT INTO Albums(AlbumID, Title, ArtistID, ReleaseDate)
VALUES (2, 'Unknown', 996, '1/1/21');