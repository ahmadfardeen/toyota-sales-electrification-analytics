USE toyota_analytics;

-- 1. GLOBAL SALES TREND

SELECT
    year,
    sales
FROM fact_global_sales
ORDER BY year;


-- 2. GLOBAL SALES YEAR-OVER-YEAR GROWTH

WITH sales_growth AS (
    SELECT
        year,
        sales,
        LAG(sales) OVER (ORDER BY year) AS previous_year_sales
    FROM fact_global_sales
)
SELECT
    year,
    sales,
    previous_year_sales,
    ROUND(
        (sales - previous_year_sales) / previous_year_sales * 100,
        2
    ) AS yoy_growth_pct
FROM sales_growth
ORDER BY year;


-- 3. 2025 SALES BY REGION
SELECT
    region,
    sales
FROM fact_regional_sales
WHERE year = 2025
ORDER BY sales DESC;


-- 4. REGIONAL SALES GROWTH: 2016 TO 2025
WITH regional_sales AS (
    SELECT
        region,
        MAX(CASE WHEN year = 2016 THEN sales END) AS sales_2016,
        MAX(CASE WHEN year = 2025 THEN sales END) AS sales_2025
    FROM fact_regional_sales
    GROUP BY region
)
SELECT
    region,
    sales_2016,
    sales_2025,
    ROUND(
        (sales_2025 - sales_2016) / sales_2016 * 100,
        2
    ) AS growth_pct
FROM regional_sales
WHERE sales_2016 IS NOT NULL
  AND sales_2025 IS NOT NULL
ORDER BY growth_pct DESC;


-- 5. GLOBAL ELECTRIFICATION TREND
SELECT
    e.year,
    e.sales AS electrified_sales,
    s.sales AS total_sales,
    ROUND(e.sales / s.sales * 100, 2) AS electrification_rate_pct
FROM fact_global_electrified_sales e
JOIN fact_global_sales s
    ON e.year = s.year
WHERE e.powertrain = 'Total'
ORDER BY e.year;


-- 6. 2025 ELECTRIFIED POWERTRAIN MIX
SELECT
    powertrain,
    sales,
    ROUND(
        sales / SUM(sales) OVER () * 100,
        2
    ) AS share_of_electrified_sales_pct
FROM fact_global_electrified_sales
WHERE year = 2025
  AND powertrain <> 'Total'
ORDER BY sales DESC;


-- 7. H1 2025 VS H1 2026 GLOBAL SALES
SELECT
    period_year,
    sales
FROM fact_h1_global_sales
ORDER BY period_year;


-- 8. H1 2026 SALES YOY
WITH h1_sales AS (
    SELECT
        MAX(CASE WHEN period_year = 2025 THEN sales END) AS sales_2025,
        MAX(CASE WHEN period_year = 2026 THEN sales END) AS sales_2026
    FROM fact_h1_global_sales
)
SELECT
    sales_2025,
    sales_2026,
    ROUND(
        (sales_2026 - sales_2025) / sales_2025 * 100,
        2
    ) AS yoy_change_pct
FROM h1_sales;


-- 9. H1 2025 VS H1 2026 REGIONAL SALES
SELECT
    region,
    MAX(CASE WHEN period_year = 2025 THEN sales END) AS h1_2025_sales,
    MAX(CASE WHEN period_year = 2026 THEN sales END) AS h1_2026_sales,
    ROUND(
        (
            MAX(CASE WHEN period_year = 2026 THEN sales END)
            -
            MAX(CASE WHEN period_year = 2025 THEN sales END)
        )
        /
        MAX(CASE WHEN period_year = 2025 THEN sales END)
        * 100,
        2
    ) AS yoy_change_pct
FROM fact_h1_regional_sales
GROUP BY region
ORDER BY yoy_change_pct DESC;


-- 10. H1 ELECTRIFIED SALES BY POWERTRAIN
SELECT
    powertrain,
    MAX(CASE WHEN period_year = 2025 THEN sales END) AS h1_2025_sales,
    MAX(CASE WHEN period_year = 2026 THEN sales END) AS h1_2026_sales,
    ROUND(
        (
            MAX(CASE WHEN period_year = 2026 THEN sales END)
            -
            MAX(CASE WHEN period_year = 2025 THEN sales END)
        )
        /
        MAX(CASE WHEN period_year = 2025 THEN sales END)
        * 100,
        2
    ) AS yoy_growth_pct
FROM fact_h1_electrified_sales
WHERE powertrain <> 'Total'
GROUP BY powertrain
ORDER BY yoy_growth_pct DESC;

-- 11. H1 GLOBAL ELECTRIFICATION RATE
SELECT
    h.period_year,
    h.sales AS electrified_sales,
    s.sales AS total_sales,
    ROUND(h.sales / s.sales * 100, 2) AS electrification_rate_pct
FROM fact_h1_electrified_sales h
JOIN fact_h1_global_sales s
    ON h.period_year = s.period_year
WHERE h.powertrain = 'Total'
ORDER BY h.period_year;


-- 12. H1 REGIONAL ELECTRIFICATION
SELECT
    e.period_year,
    e.region,
    e.electrified_sales,
    s.sales AS total_sales,
    ROUND(
        e.electrified_sales / s.sales * 100,
        2
    ) AS electrification_rate_pct
FROM fact_h1_regional_electrified_sales e
JOIN fact_h1_regional_sales s
    ON e.period_year = s.period_year
    AND e.region = s.region
ORDER BY e.region, e.period_year;


-- 13. TOP MAJOR MODELS BY GLOBAL SALES
SELECT
    model,
    sales_thousands
FROM fact_major_model_sales
ORDER BY sales_thousands DESC;


-- 14. REGIONAL MODEL SALES
SELECT
    region,
    model,
    sales_thousands
FROM fact_regional_model_sales
ORDER BY region, sales_thousands DESC;

-- 15. GLOBAL POWERTRAIN MIX
SELECT
    powertrain,
    sales_thousands,
    ROUND(
        sales_thousands /
        SUM(
            CASE
                WHEN powertrain <> 'Total'
                THEN sales_thousands
                ELSE 0
            END
        ) OVER () * 100,
        2
    ) AS share_pct
FROM fact_global_powertrain_sales
WHERE powertrain <> 'Total'
ORDER BY sales_thousands DESC;


-- 16. GLOBAL PRODUCTION TREND
SELECT
    year,
    production
FROM fact_global_production
ORDER BY year;


-- 17. PRODUCTION YEAR-OVER-YEAR GROWTH
WITH production_growth AS (
    SELECT
        year,
        production,
        LAG(production) OVER (ORDER BY year) AS previous_year_production
    FROM fact_global_production
)
SELECT
    year,
    production,
    previous_year_production,
    ROUND(
        (production - previous_year_production)
        / previous_year_production * 100,
        2
    ) AS yoy_growth_pct
FROM production_growth
ORDER BY year;

-- 18. PRODUCTION INSIDE VS OUTSIDE JAPAN
SELECT
    year,
    production_scope,
    production
FROM fact_regional_production
ORDER BY year, production_scope;

-- 19. 2025 PRODUCTION SHARE: INSIDE VS OUTSIDE JAPAN
SELECT
    production_scope,
    production,
    ROUND(
        production /
        SUM(production) OVER () * 100,
        2
    ) AS production_share_pct
FROM fact_regional_production
WHERE year = 2025;


-- 20. SALES VS PRODUCTION
SELECT
    s.year,
    s.sales,
    p.production,
    p.production - s.sales AS production_minus_sales
FROM fact_global_sales s
JOIN fact_global_production p
    ON s.year = p.year
ORDER BY s.year;

-- 21. VEHICLE SPECIFICATIONS BY POWERTRAIN
SELECT
    model,
    powertrain_category,
    COUNT(*) AS configuration_count,
    ROUND(AVG(power_hp), 2) AS avg_power_hp,
    ROUND(AVG(fuel_economy_combined_l100), 2) AS avg_fuel_economy_l100
FROM dim_vehicle_specs
GROUP BY
    model,
    powertrain_category
ORDER BY
    model,
    powertrain_category;
