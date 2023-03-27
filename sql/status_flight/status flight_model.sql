select 
distinct  
count(f.flight_id)
, a.model
, f.status
from bookings.flights f 
inner join bookings.aircrafts a 
on f.aircraft_code = a.aircraft_code 
group by 
  a.model
, f.status