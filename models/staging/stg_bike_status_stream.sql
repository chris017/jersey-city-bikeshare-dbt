with source as (

    select * from {{ source('raw', 'raw_bike_status_stream') }}

),

renamed as (

    select
        event_id,
        bike_id,
        station_id,
        station_name,
        bikes_available,
        docks_available,
        event_timestamp,
        loaded_at,
        datediff('second', event_timestamp, loaded_at) as ingestion_lag_seconds
    from source

)

select * from renamed