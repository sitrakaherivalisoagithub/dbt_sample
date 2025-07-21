-- models/datawarehouse/rpt_customer_lifetime_value.sql

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.country,
    c.support_representative_name,
    -- On agrège les montants des factures pour chaque client
    SUM(i.total_amount) AS lifetime_value,
    COUNT(DISTINCT i.invoice_id) AS number_of_invoices
FROM
    {{ ref('stg_invoices') }} AS i
LEFT JOIN
    {{ ref('dim_customers') }} AS c
    ON i.customer_id = c.customer_id
GROUP BY
    1, 2, 3, 4, 5
ORDER BY
    lifetime_value DESC