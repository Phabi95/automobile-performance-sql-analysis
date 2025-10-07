-- Detect outliers by horsepower using Z-Score (CTE)

WITH z_scores AS (
    SELECT
        m.make,
        e.horsepower,
        ROUND(
            (e.horsepower - AVG(e.horsepower) OVER (PARTITION BY m.make)) 
            / STDDEV(e.horsepower) OVER (PARTITION BY m.make), 
            2
        ) AS z_score
    FROM cars c
    JOIN manufacturers m USING (manufacturer_id)
    JOIN engines e USING (car_id)
)
SELECT *
FROM z_scores
WHERE z_score > 2
ORDER BY make, z_score DESC;


