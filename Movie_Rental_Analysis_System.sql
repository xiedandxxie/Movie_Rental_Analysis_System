CREATE DATABASE MovieRental;

CREATE TABLE rental_data (
    MOVIE_ID integer,
    CUSTOMER_ID integer,
    GENRE varchar(50),
    RENTAL_DATE date,
    RETURN_DATE date,
    RENTAL_FEE numeric(5,2)
);

INSERT INTO rental_data (MOVIE_ID, CUSTOMER_ID, GENRE, RENTAL_DATE, RETURN_DATE, RENTAL_FEE) VALUES
(1, 101, 'Action', '2025-03-01', '2025-03-03', 5.99),
(2, 102, 'Comedy', '2025-03-02', '2025-03-04', 4.99),
(3, 103, 'Drama', '2025-03-03', '2025-03-06', 5.99),
(4, 104, 'Action', '2025-03-04', '2025-03-07', 6.99),
(5, 105, 'Sci-Fi', '2025-03-05', '2025-03-08', 7.99),
(1, 106, 'Action', '2025-04-01', '2025-04-03', 5.99),
(2, 107, 'Comedy', '2025-04-02', '2025-04-05', 4.99),
(3, 108, 'Drama', '2025-04-03', '2025-04-06', 5.99),
(4, 109, 'Action', '2025-04-04', '2025-04-07', 6.99),
(5, 110, 'Sci-Fi', '2025-04-05', '2025-04-08', 7.99),
(1, 101, 'Action', '2025-05-01', '2025-05-03', 5.99),
(2, 102, 'Comedy', '2025-05-02', '2025-05-05', 4.99),
(3, 103, 'Drama', '2025-05-03', '2025-05-06', 5.99),
(4, 104, 'Action', '2025-05-04', '2025-05-07', 6.99),
(5, 105, 'Sci-Fi', '2025-05-05', '2025-05-08', 7.99);

SELECT 
    GENRE,
    MOVIE_ID,
    COUNT(*) as RENTAL_COUNT,
    SUM(RENTAL_FEE) as TOTAL_REVENUE
FROM 
    rental_data
GROUP BY 
    GROUPING SETS ((GENRE), (GENRE, MOVIE_ID))
ORDER BY 
    GENRE, MOVIE_ID;

SELECT 
    GENRE,
    SUM(RENTAL_FEE) as TOTAL_REVENUE
FROM 
    rental_data
GROUP BY 
    ROLLUP(GENRE)
ORDER BY 
    GENRE;

SELECT 
    COALESCE(GENRE, 'All Genres') as GENRE,
    COALESCE(TO_CHAR(DATE_TRUNC('month', RENTAL_DATE), 'YYYY-MM'), 'All Months') as RENTAL_MONTH,
    COALESCE(CAST(CUSTOMER_ID AS VARCHAR), 'All Customers') as CUSTOMER_ID,
    COUNT(*) as RENTAL_COUNT,
    SUM(RENTAL_FEE) as TOTAL_REVENUE
FROM 
    rental_data
GROUP BY 
    CUBE(GENRE, DATE_TRUNC('month', RENTAL_DATE), CUSTOMER_ID)
ORDER BY 
    CASE WHEN GENRE IS NULL THEN 1 ELSE 0 END,
    GENRE,
    CASE WHEN DATE_TRUNC('month', RENTAL_DATE) IS NULL THEN 1 ELSE 0 END,
    DATE_TRUNC('month', RENTAL_DATE),
    CASE WHEN CUSTOMER_ID IS NULL THEN 1 ELSE 0 END,
    CUSTOMER_ID;

SELECT 
    MOVIE_ID,
    CUSTOMER_ID,
    RENTAL_DATE,
    RETURN_DATE,
    RENTAL_FEE
FROM 
    rental_data
WHERE 
    GENRE = 'Action'
ORDER BY 
    RENTAL_DATE;

SELECT
MOVIE_ID,
    CUSTOMER_ID,
    GENRE,
    RENTAL_DATE,
    RETURN_DATE,
    RENTAL_FEE
FROM 
    rental_data
WHERE 
    GENRE IN ('Action', 'Drama')
    AND RENTAL_DATE >= '2025-03-01'  
    AND RENTAL_DATE <= '2025-05-29'
ORDER BY 
    GENRE, RENTAL_DATE;
