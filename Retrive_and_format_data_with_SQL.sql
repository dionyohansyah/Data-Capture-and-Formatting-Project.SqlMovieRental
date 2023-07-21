select 
	c.customer_id,
     case 
		when active = 1 then 'active'
        when active = 0 then 'non active'
	end as status,
    concat(c.first_name, ' ', c.last_name) as name,
    cl.country,
    p.rental_id,
	fl.title as movie_title,
    f.length,
    fl.category,
    fl.rating,
    fl.price,
    f.rental_duration,
    date(p.payment_date) as payment_date,
    date(r.rental_date) as rental_date,
    date(r.return_date) as return_date,
    datediff(return_date, rental_date) as return_duration,
    case 
		when datediff(return_date, rental_date) > rental_duration then 'late'
        else 'on time'
	end as return_status,
    p.amount
from
	customer as c
join
	customer_list as cl
		on c.customer_id = cl.id
join
	payment as p
		on c.customer_id = p.customer_id
join
	rental as r
		on p.rental_id = r.rental_id
join
	inventory as i
		on r.inventory_id = i.inventory_id
join
	film_list as fl
		on i.film_id = fl.fid
join
	film as f
		on fl.fid = f.film_id
order by p.rental_id
