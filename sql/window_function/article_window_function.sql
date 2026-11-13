-- ROW_NUMBER()
SELECT
    ROW_NUMBER() OVER (
        ORDER BY Name
    ) AS RowNum,
    Name
FROM Artist
LIMIT 10;

-- RANK()
SELECT
    RANK() OVER (
      ORDER BY Milliseconds DESC
    ) AS RankNum,
    Name,
    Milliseconds
FROM Track
LIMIT 10;

-- Aggregate function
SELECT
    CustomerId,
    InvoiceId,
    Total,
    SUM(Total) OVER (
        PARTITION BY CustomerId
    ) AS CustomerTotal
FROM Invoice
ORDER BY CustomerId;

-- LAG()
SELECT
    CustomerId,
    InvoiceId,
    InvoiceDate,
    Total,
    LAG(Total) OVER (
        PARTITION BY CustomerId
        ORDER BY InvoiceDate
    ) AS PreviousInvoice
FROM Invoice;

-- LEAD()
SELECT
    CustomerId,
    InvoiceId,
    InvoiceDate,
    Total,
    LEAD(Total) OVER (
        PARTITION BY CustomerId
        ORDER BY InvoiceDate
    ) AS NextInvoice
FROM Invoice;