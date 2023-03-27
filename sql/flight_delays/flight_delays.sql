/*flight delays*/

--create extension cube;
--create extension earthdistance

with pas_capacity as (select  
					 a.aircraft_code
			         , a.model
			         , count(s.seat_no) as seat
			  from    aircrafts a
			  inner join seats s 
			  on a.aircraft_code = s.aircraft_code
			  group by 
					a.aircraft_code
					, a.model)
							
select  
       DENSE_RANK() OVER(ORDER BY difference) as rank
	  , difference
	  , flight_id 
	  , flight_no 
	  , range.model
	  , route_name 
	  , route_code
	  , range.flight_time
  	  , to_char(distance_fact/distance_max,'FM90.999') as cof_distance /*факт. дист./макс. дист.*/
	  , round((amount_passengers*1.0)/(pas_capacity.seat*1.0),3) as cof_passengers /*факт. пассажир./кол.-во посадочных мест*/
from  (select      
			  flight_id 
			, flight_no 
			, code	
			, departure_name || ' -> ' ||city.arrival_name as route_name 
			, departure || ' -> ' ||city.arrival as route_code 
			, difference 
			, amount_passengers 
	        , a.model as model
			, city.flight_time as flight_time
			, a."range" as distance_max
	        ,(arrivals.coordinates <@> departures.coordinates) as distance_fact
	 from
			(select
				   fv.flight_id as flight_id 
				 , fv.flight_no as flight_no
				 , fv.aircraft_code as code 
				 , fv.departure_airport_name as departure_name 
				 , fv.arrival_airport_name as arrival_name 
				 , f.departure_airport  as departure 
			     , f.arrival_airport  as arrival
			     , fv.scheduled_duration as flight_time
			     , count(tf.ticket_no) as amount_passengers
				 ,case 
					when fv.actual_duration is null 
					then fv.scheduled_duration - fv.scheduled_duration 
					else fv.scheduled_duration - fv.actual_duration  
					end as difference 
			from bookings.flights f 
			inner join bookings.ticket_flights tf  
			on tf.flight_id = f.flight_id
			inner join bookings.flights_v fv 
			on fv.flight_id = f.flight_id 
			group by
					  fv.flight_id
					, fv.flight_no
					, fv.aircraft_code
					, fv.departure_airport_name
					, fv.arrival_airport_name
					, departure
					, arrival
					, fv.actual_duration
					, fv.scheduled_duration
			order by difference	
			limit 20 ) as city 
		inner join bookings.airports arrivals
		on arrivals.airport_code = city.departure
	    inner join bookings.airports departures
		on departures.airport_code = city.arrival
		inner join bookings.aircrafts a 
		on a.aircraft_code = city.code) as range
inner join pas_capacity
on range.model = pas_capacity.model