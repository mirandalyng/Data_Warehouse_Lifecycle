with src_employer as (select * from {{ ref('src_employer') }})
select
    {{ dbt_utils.generate_surrogate_key(['employer_workplace', 'workplace_municipality']) }} as employer_id,
    max(coalesce(employer_organization_number, 'Saknas organisationsnummer')) as employer_organization_number, 
    max(coalesce(employer_name, 'Saknas namn')) as employer_name,
    max(coalesce(employer_workplace, 'Saknas namn på arbetsplats')) as employer_workplace, 
    max(coalesce(webpage_url, 'Saknas webbaddress')) as webpage_url, 
    max(coalesce(workplace_city,'Saknas stad')) as workplace_city,
    max(coalesce(workplace_municipality, 'Saknas kommun')) as workplace_municipality,
    max(coalesce(workplace_street_address, 'Saknas address')) as workplace_street_address, 
    max(coalesce(workplace_region, 'Saknas region')) as workplace_region,
    max(coalesce(workplace_country, 'Saknas land')) as workplace_country
from
    src_employer
group by 
    employer_id


