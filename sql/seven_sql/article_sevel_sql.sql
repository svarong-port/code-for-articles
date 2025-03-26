-- Chinook dataset
-- From https://github.com/lerocha/chinook-database/blob/80466f670c4cac735cf3abcc0c7caeeecfb23587/ChinookDatabase/DataSources/Chinook_Sqlite.sql



-- SELECT
SELECT Name, AlbumId
FROM Track;

-- SELECT with AS
SELECT Name AS Song, AlbumId AS Album
FROM Track;



-- WHERE
SELECT Name, UnitPrice
FROM Track
WHERE UnitPrice > 0.99;

-- WHERE and LIKE _ (1)
SELECT FirstName, LastName
FROM Customer
WHERE FirstName LIKE '_ohn';

-- WHERE and LIKE % (2)
SELECT FirstName, LastName
FROM Customer
WHERE FirstName LIKE 'J%';



-- ORDER BY
SELECT FirstName, LastName
FROM Customer
ORDER BY FirstName;

-- ORDER BY with DESC
SELECT FirstName, LastName
FROM Customer
ORDER BY FirstName DESC;


-- GROUP BY
SELECT AlbumId, COUNT(*) AS TrackCount
FROM Track
GROUP BY AlbumId;



-- Aggregate functions
SELECT CustomerId, COUNT(*), SUM(Total) AS TotalSpent, AVG(Total) AS AverageSpent
FROM Invoice
GROUP BY CustomerId;

-- Aggregate functions with ROUND
SELECT CustomerId, COUNT(*), ROUND(SUM(Total), 2) AS TotalSpent, ROUND(AVG(Total), 2) AS AverageSpent
FROM Invoice
GROUP BY CustomerId;



-- JOIN
SELECT Track.Name AS TrackName, Album.Title AS AlbumName
FROM Track
JOIN Album
ON Track.AlbumId = Album.AlbumId;



-- LIMIT
SELECT FirstName, LastName
FROM Customer
LIMIT 10;



-- Put it all together
SELECT Album.Title AS AlbumName, SUM(Track.UnitPrice) AS TotalRevenue
FROM Album
JOIN Track
ON Album.AlbumId = Track.AlbumId
WHERE Track.UnitPrice > 0.99
GROUP BY Album.AlbumId
ORDER BY TotalRevenue DESC
LIMIT 5;