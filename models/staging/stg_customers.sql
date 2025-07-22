-- models/staging/stg_customers.sql

WITH source AS (
    -- On sélectionne les données brutes de la table customer
    SELECT
        customer_id,
        first_name,
        last_name,
        company,
        city,
        state,
        country,
        support_rep_id as support_representative_id
    FROM
        {{ source('chinook', 'customer') }}
)

SELECT
    *
FROM
    source