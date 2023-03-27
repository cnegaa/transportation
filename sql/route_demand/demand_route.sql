/*most popular route  */
select pass1.*from
(select 
     fv.flight_no as route_number
	,count(t.passenger_id) as  count_passenger
	,sum(tf.amount) as 	sum_amount
	, fv.departure_city   || ' -> ' || fv.arrival_city as route
from bookings.tickets t 
inner join bookings.ticket_flights tf 
on tf.ticket_no = t.ticket_no
inner join bookings.flights_v fv 
on tf.flight_id = fv.flight_id
group by fv.flight_no
		,fv.departure_city
		,fv.arrival_city
order by count_passenger desc
limit 5) as pass1
union all 
select pass2.*from
(select 
     fv.flight_no as route_number
	,count(t.passenger_id) as  count_passenger
	,sum(tf.amount) as 	sum_amount
	, fv.departure_city   || ' -> ' || fv.arrival_city as route
from bookings.tickets t 
inner join bookings.ticket_flights tf 
on tf.ticket_no = t.ticket_no
inner join bookings.flights_v fv 
on tf.flight_id = fv.flight_id
group by fv.flight_no
		,fv.departure_city
		,fv.arrival_city
order by count_passenger asc
limit 5) as pass2
