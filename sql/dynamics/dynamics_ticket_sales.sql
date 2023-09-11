/*dynamics_ticket_sales*/
select /*Business*/
	tab.conditions as conditions
	, tab.month as month
	, sum(ticket_sales) as ticket_sales
	, lag (sum(ticket_sales),1) over(order by month) as ticket_sales_yesterday
	, sum(ticket_sales)- lag (sum(ticket_sales),1) over(order by month) as dynamics_ticket_sales
from (
	select   
	    tf.fare_conditions as conditions
	    , f.scheduled_departure::date as dat
	    , to_char (f.scheduled_departure, 'MM') as month
	    , count(tf.amount) as ticket_sales
	from flights f
		inner join ticket_flights tf 
		on f.flight_id = tf.flight_id 
	where tf.fare_conditions = 'Business'
	and f.scheduled_departure::date BETWEEN '2016.09.01' and '2017.08.31' -- убрали наложение дат (август,сентябрь)
	group by tf.fare_conditions, dat, month
) as tab
group by conditions, month
union all 
select /*Comfort*/
	tab.conditions as conditions
	, tab.month as month
	, sum(ticket_sales) as ticket_sales
	, lag (sum(ticket_sales),1) over(order by month) as ticket_sales_yesterday
	, sum(ticket_sales)- lag (sum(ticket_sales),1) over(order by month) as dynamics_ticket_sales
from (
	select   
	    tf.fare_conditions as conditions
	    , f.scheduled_departure::date as dat
	    , to_char (f.scheduled_departure, 'MM') as month
	    , count(tf.amount) as ticket_sales
	from flights f
		inner join ticket_flights tf 
		on f.flight_id = tf.flight_id 
	where tf.fare_conditions = 'Comfort'
	and f.scheduled_departure::date BETWEEN '2016.09.01' and '2017.08.31'
	group by tf.fare_conditions, dat, month
) as tab
group by conditions, month
union all 
select /*Economy*/
	tab.conditions as conditions
	, tab.month as month
	, sum(ticket_sales) as ticket_sales
	, lag (sum(ticket_sales),1) over(order by month) as ticket_sales_yesterday
	, sum(ticket_sales)- lag (sum(ticket_sales),1) over(order by month) as dynamics_ticket_sales
from (
	select   
	    tf.fare_conditions as conditions
	    , f.scheduled_departure::date as dat
	    , to_char (f.scheduled_departure, 'MM') as month
	    , count(tf.amount) as ticket_sales
	from flights f
		inner join ticket_flights tf 
		on f.flight_id = tf.flight_id 
	where tf.fare_conditions = 'Economy'
	and f.scheduled_departure::date BETWEEN '2016.09.01' and '2017.08.31'
	group by tf.fare_conditions, dat, month
) as tab
group by conditions, month