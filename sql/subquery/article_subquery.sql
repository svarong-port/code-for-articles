-- Subquery in SELECT
SELECT
    InvoiceId,
    Total,
    (
        SELECT AVG(Total)
        FROM Invoice -- Subquery
    ) AS Mean
FROM Invoice;


-- Subquery in WHERE
SELECT
    InvoiceId,
    Total
FROM Invoice
WHERE Total > (
    SELECT AVG(Total)
    FROM Invoice -- Subquery
);


-- Subquery in JOIN
SELECT
    c.FirstName,
    c.LastName,
    s.TotalSpent
FROM Customer AS c
JOIN (
    SELECT
        CustomerId,
        SUM(Total) AS TotalSpent
    FROM Invoice
    GROUP BY CustomerId
) AS s -- Subquery
    ON c.CustomerId = s.CustomerId;


-- Correlated subquery
SELECT
    t.Name,
    t.Milliseconds,
    t.GenreId
FROM Track AS t
WHERE t.Milliseconds > (
    SELECT AVG(t2.Milliseconds)
    FROM Track AS t2
    WHERE t2.GenreId = t.GenreId -- Refer to column in main query
);


-- Nested subquery
SELECT
    Name,
    Milliseconds
FROM Track
WHERE Milliseconds > ( -- First subquery
    SELECT AVG(Milliseconds)
    FROM Track
    WHERE GenreId = ( -- Second subquery
        SELECT GenreId
        FROM Genre
        WHERE Name = 'Rock'
    )
);


-- Subquery without WITH
SELECT
    CustomerId,
    SUM(Total) AS total_spent
FROM Invoice
GROUP BY CustomerId
HAVING SUM(Total) > (
    SELECT AVG(customer_total)
    FROM (
        SELECT
            CustomerId,
            SUM(Total) AS customer_total
        FROM Invoice
        GROUP BY CustomerId
    ) AS customer_spending
);


-- Subquery with WITH
-- Use WITH to create CTE
WITH customer_spending AS (
    SELECT
        CustomerId,
        SUM(Total) AS total_spent
    FROM Invoice
    GROUP BY CustomerId
),
average_spending AS (
    SELECT AVG(total_spent) AS avg_spent
    FROM customer_spending
)


-- SELECT with CTE
SELECT
    CustomerId,
    total_spent
FROM customer_spending -- CTE
WHERE total_spent > (
    SELECT avg_spent
    FROM average_spending -- CTE
);