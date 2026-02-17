USE Retail_Analysis;


ALTER TABLE Rtranscation ADD InvoiceDate_Clean DATETIME2;

UPDATE Rtranscation
SET InvoiceDate_Clean = CONVERT(DATETIME2, REPLACE(InvoiceDate, '.', ':'), 105);

WITH RFM_Base AS (
    SELECT 
        Customer_ID,
        DATEDIFF(DAY, MAX(InvoiceDate_Clean), (SELECT MAX(InvoiceDate_Clean) FROM Rtranscation)) AS Recency,
        COUNT(DISTINCT Invoice) AS Frequency,
        SUM(Quantity * Price) AS Monetary
    FROM Rtranscation
    WHERE Customer_ID IS NOT NULL
    GROUP BY Customer_ID
),
RFM_Scores AS (
    SELECT 
        Customer_ID,
        Recency, Frequency, Monetary,
        NTILE(4) OVER (ORDER BY Recency DESC) AS R_Score,
        NTILE(4) OVER (ORDER BY Frequency ASC) AS F_Score,
        NTILE(4) OVER (ORDER BY Monetary ASC) AS M_Score
    FROM RFM_Base
)
SELECT 
    Customer_ID, 
    Recency, Frequency, Monetary,
    CONCAT(R_Score, F_Score, M_Score) AS RFM_Cell,
    CASE 
        WHEN (R_Score = 4 AND F_Score = 4 AND M_Score = 4) THEN 'Champions'
        WHEN (R_Score >= 3 AND F_Score >= 3 AND M_Score >= 3) THEN 'Loyal'
        WHEN (R_Score = 4 AND M_Score = 1) THEN 'New Customers'
        WHEN (R_Score = 1 AND F_Score = 4) THEN 'Can’t Lose Them'
        WHEN (R_Score = 1 AND F_Score = 1) THEN 'Lost'
        ELSE 'At Risk'
    END AS Customer_Segment
FROM RFM_Scores
ORDER BY Monetary DESC;