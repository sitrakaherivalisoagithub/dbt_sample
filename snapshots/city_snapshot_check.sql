{% snapshot city_snapshot_check %}

    {{
        config(
          target_schema='snapshots',
          strategy='check',
          unique_key='customer_id',
          check_cols=['city'],
        )
    }}

    select * from {{source('chinook','customer')}}

{% endsnapshot %}