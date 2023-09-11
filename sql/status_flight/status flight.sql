/*status flight*/

select
	  month
	, status
	, conditions
	, sum(count_ticket) as ticket
	, sum(sum_amount) as amount
	, array_agg(model)
from
(select
	  flights.month 
	, flights.status
	, flights.model
	, flights.conditions
	, count(flights.ticket) as count_ticket
	, sum(flights.amount) as sum_amount
from 
(select 
	  to_char(f.scheduled_departure, 'Month')as month
	, extract(month from scheduled_departure) as no_month
	, f.status as status
	, f.aircraft_code as code
	, a.model as model
	, tf.amount as amount
	, tf.ticket_no as ticket
	, tf.fare_conditions as conditions
from bookings.flights f 
inner join bookings.aircrafts a 
on a.aircraft_code = f.aircraft_code 
inner join bookings.ticket_flights tf 
on tf.flight_id = f.flight_id ) as flights
group by  
          flights.month
		, flights.status
		, flights.model
		, flights.conditions
		, flights.no_month) as pas
group by   month
		   , status
		   , conditions
order by status