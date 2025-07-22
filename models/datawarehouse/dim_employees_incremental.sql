-- models/datawarehouse/dim_employees_incremental.sql
{{
    config(
        materialized='incremental',
        unique_key='employee_id'
    )
}}

SELECT
    {{ dbt_utils.generate_surrogate_key(['employee_id', 'hire_date']) }} AS surrogate_id,
    employee_id,
    first_name,
    last_name,
    title,
    reports_to AS reports_to_employee_id,
    city,
    -- NOTE : Pour un modèle incrémental efficace, une colonne de timestamp de dernière modification est cruciale.
    -- Nous la simulons ici avec la date d'embauche. Dans un vrai projet, ce serait une colonne comme `_last_modified_at`.
    CAST(hire_date AS TIMESTAMP) AS last_modified_timestamp

FROM
    {{ source('chinook', 'employee') }}

{% if is_incremental() %}

  -- Lors des exécutions incrémentielles, ne traiter que les lignes nouvelles ou modifiées
  -- depuis la dernière exécution.
  WHERE CAST(hire_date AS TIMESTAMP) > (SELECT max(last_modified_timestamp) FROM {{ this }})

{% endif %}