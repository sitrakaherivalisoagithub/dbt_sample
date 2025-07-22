{% snapshot employees_snapshot %}

{{
    config(
        target_schema='scd',
        unique_key='employee_id',
        strategy='check',
        check_cols=['title', 'reports_to_employee_id']
    )
}}

SELECT * FROM {{ ref('dim_employees_incremental')}} 

{% endsnapshot %}