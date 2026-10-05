with stg_job_ads as (select * from {{ source('job_ads', 'stg_ads') }})

select
    id,
    occupation__label as occupation,
    employer__workplace as employer_workplace,
    workplace_address__municipality as workplace_municipality,
    experience_required,
    driving_license_required as driver_license,
    access_to_own_car,
    number_of_vacancies as vacancies,
    relevance,
    application_deadline
from stg_job_ads