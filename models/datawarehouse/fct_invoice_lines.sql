-- models/datawarehouse/fct_invoice_lines.sql

SELECT
    il.invoice_line_id AS invoice_line_id,
    i.invoice_id,
    i.customer_id,
    i.invoice_date,
    t.name AS track_name,
    ar.name AS artist_name,
    il.unit_price AS unit_price,
    il.quantity AS quantity,
    -- On calcule le montant total pour la ligne
    (il.unit_price * il.quantity) AS line_total_amount
FROM
    {{ source('chinook', 'invoice_line') }} AS il
LEFT JOIN
    {{ ref('stg_invoices') }} AS i
    ON il.invoice_id = i.invoice_id
LEFT JOIN
    {{ source('chinook', 'track') }} AS t
    ON il.track_id = t.track_id
LEFT JOIN
    {{ source('chinook', 'artist') }} AS ar
    ON t.album_id = ar.artist_id