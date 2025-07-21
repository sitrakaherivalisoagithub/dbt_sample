-- models/datawarehouse/dim_customers.sql

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.company,
    c.city,
    c.state,
    c.country,
    -- Concaténation du nom et prénom de l'employé support
    e.first_name || ' ' || e.last_name AS support_representative_name
FROM
    -- On utilise ref() pour faire référence à notre modèle de staging client
    {{ ref('stg_customers') }} AS c
LEFT JOIN
    -- On joint avec la table brute des employés
    {{ source('chinook', 'employee') }} AS e
ON
    c.support_representative_id = e.employee_id