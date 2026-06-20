with ranked as (

    select
        *,
        row_number() over (partition by station_id order by event_timestamp desc) as rn
    from {{ ref('stg_bike_status_stream') }}

)

select
    station_id,
    station_name,
    bikes_available,
    docks_available,
    event_timestamp as last_updated_at
from ranked
where rn = 1