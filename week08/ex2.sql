--select distinct film.film_id, film.title, film.description
explain select *
from film
join film_category
    on film_category.film_id = film.film_id
join category
    on category.category_id = film_category.category_id
where film.rating in ('R', 'PG-13')
and category.name in ('Horror', 'Sci-fi')
and film.film_id not in
    (select film.film_id from film
    left join inventory on film.film_id = inventory.film_id
    join rental on rental.inventory_id = inventory.inventory_id);

-- The most expensive operation is sequential scan through
-- film category. We can fix it by creating an index on
-- film_category.film_id

explain select sum(amount), store.store_id
from payment
join rental
on rental.rental_id = payment.rental_id
join staff
on staff.staff_id = rental.staff_id
join store
on store.store_id = staff.store_id
where date_part('epoch', payment_date) > (date_part('epoch',
    (select max(payment_date) from payment)) - 2592000)
group by (store.store_id)
order by sum(amount) desc
limit 1;

-- I printed the best (only one) selling store
-- I assume that by "the last month recorded" 30 days from the
-- last record were meant

-- in this case the most expensive operation is
-- sequential scan through the payment
-- following the same logic we can create an index on
-- payment.rental_id, so the join works faster