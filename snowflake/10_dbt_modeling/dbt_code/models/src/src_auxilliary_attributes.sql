with stg_job_ads as (select * from {{ source('job_ads', 'stg_ads') }})

select  
    experience_required, --pk
    driving_license_required as driver_license, --pk
    access_to_own_car --pk
from stg_job_ads