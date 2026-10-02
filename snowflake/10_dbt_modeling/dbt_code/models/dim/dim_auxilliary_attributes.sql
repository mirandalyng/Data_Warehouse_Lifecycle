with dim_auxilliary_attributes as (select * from {{ ref('src_auxilliary_attributes') }})



select  
    {{dbt_utils.generate_surrogate_key(['experience_required', 'driver_license', 'access_to_own_car'])}} as auxilliary_attributes_id, 
    max(experience_required) as experience_required,
    max(driver_license) as driver_license, 
    max(access_to_own_car) as access_to_own_car
from dim_auxilliary_attributes
group by auxilliary_attributes_id