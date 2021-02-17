{%- set source_relation = adapter.get_relation(
      database=source('zendesk', 'ticket_schedule').database,
      schema=source('zendesk', 'ticket_schedule').schema,
      identifier=source('zendesk', 'ticket_schedule').name) -%}

{% set table_exists=source_relation is not none  %}

{% if table_exists %}
{{ log("Table exists", info=True) }}

select * 
from {{ source('zendesk', 'ticket_schedule') }}

{% else %}
{{ log("Table does not exists", info=True) }}

select
    cast(null as {{ dbt_utils.type_timestamp() }}) as _fivetran_synced,
    cast(null as {{ dbt_utils.type_timestamp() }}) as created_at,
    cast(null as {{ dbt_utils.type_int() }}) as schedule_id,
    cast(null as {{ dbt_utils.type_int() }}) as ticket_id

{% endif %}