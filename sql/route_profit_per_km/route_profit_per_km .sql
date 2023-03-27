/*route profit per km*/

--create extension cube;
--create extension earthdistance

select 		
		departure_city || ' -> ' || arrival_city as route_city
		, departure || ' -> ' || arrival as route_code
		, (flight_amount / total_distance*1.00) as revenue_per_km 
from 	
		(select   
				schedule.departure_city
				, schedule.arrival_city
				, schedule.departure
		        , schedule.arrival
		        , (arrivals.coordinates <@> departures.coordinates) * flights_count as total_distance
		        , flight_amount
		 from
				(select
					 fv.departure_city as  departure_city
					 , fv.arrival_city as arrival_city
					 , f.departure_airport  as departure
				     , f.arrival_airport  as arrival
				     , sum(tf.amount) as flight_amount
				     , count(distinct f.flight_id) as flights_count
				from bookings.flights f 
				inner join bookings.ticket_flights tf 
				on tf.flight_id = f.flight_id
				inner join bookings.flights_v fv 
				on fv.flight_id = f.flight_id 
				group by 
						arrival
						, departure
						, fv.arrival_city
						, fv.departure_city
				order by flights_count desc) as schedule
			inner join bookings.airports arrivals
			on arrivals.airport_code = schedule.departure
		    inner join bookings.airports departures
			on departures.airport_code = schedule.arrival) as flights_data
			limit 10
