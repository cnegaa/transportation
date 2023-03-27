# transportation
Для проекта взята БД авиаперевозок по России за год с сайта: https://www.postgrespro.ru/ 
БД имеет структуру: 
<img src="https://github.com/cnegaa/transportation/blob/master/structure/structure_bd.jpg" alt="структура" />


1) Анализируя данные авиаперевозок, рассмотрим такие статусы рейсов как: "Arrived", "Cancelled","Delayed", "On Time","Scheduled" При этом ответим на вопросы:
1.	Какой процент пассажиров прибыло в место назначения по каждому статусу рейса
2.	Какая выручка была у авиакомпаний по каждому статуса рейса
3.	Какие модели самолетов совершали рейсы каждого статуса.

График "status_flight_mode"
<img src="https://github.com/cnegaa/transportation/blob/master/img_chart/route_demand/status_flight_model.png" />

График "status_flight_revenue"
<img src="https://github.com/cnegaa/transportation/blob/master/img_chart/route_demand/status_flight_revenue.png" />

График "status_flight_passengers"


2) Рассмотрим более подробно рейсы со статусом "Delayed"
При этом ответим на вопросы:
1.	Какое максимальное опоздание рейса,
2.	Какие мадели самолетов чаще всего задервиваются на рейсе,
3.	Насколько популярны данные рейсы,
4.	Насколько продолжительный маршрут у рейса,
5.	Продолжительность полета.


<img src="https://github.com/cnegaa/transportation/blob/master/img_chart/flight_delays/flight_delays_dist_767-300.png" />
<img src="https://github.com/cnegaa/transportation/blob/master/img_chart/flight_delays/flight_delays_dist_A319-100.png" />
<img src="https://github.com/cnegaa/transportation/blob/master/img_chart/flight_delays/flight_delays_pas_767-300.png" />
<img src="https://github.com/cnegaa/transportation/blob/master/img_chart/flight_delays/flight_delays_pas_A319.png" />

выведен топ 20 рейсов с наибольшим опозданием. 
<a href="URL">текст ссылки</a>

3) Рассмотрим наиболее популярные и не популярные маршруты.
При этом ответим на вопросы:
1.	Количество пассажиров на пяти самых популярных маршрутов,
2.	Количество пассажиров на пяти самых не популярных маршрутов,
3.	Выручка от пяти самых популярных маршрутов,
4.	Выручка от пяти самых не популярных маршрутов


4) Рассмотрим маршруты, где максимальная выручка на пройденный километр пути. При этом ответим на вопросы:
1.	Какой наиболее выгодный маршрут для авиакомпаний
2.	Максимальная выручка на 1 км полета

<img src="https://github.com/cnegaa/transportation/blob/master/img_chart/route_profit_per_km/route_profit_per_km.png" />
