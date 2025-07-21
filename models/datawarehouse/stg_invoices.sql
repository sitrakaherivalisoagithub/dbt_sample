-- models/datawarehouse/stg_invoices.sql

WITH source AS (
    -- On sélectionne les données brutes de la table invoice
    SELECT
        invoice_id,
        customer_id,
        -- Convertit la date en timestamp pour les calculs
        CAST(invoice_date AS TIMESTAMP) AS invoice_date,
        total AS total_amount
    FROM
        {{ source('chinook', 'invoice') }}
)

SELECT
    *
FROM
    source