use movierating;

#1. For each rating that is the lowest (fewest stars) currently in the database, return the reviewer name, movie title, and number of stars.
select name, title, stars
from movie natural join rating natural join reviewer
where stars = (select min(stars) from rating);

#2. List movie titles and average ratings, from highest-rated to lowest-rated. If two or more movies have the same average rating, list them in alphabetical order.
create view movieAvgRating as
	select m.*, avg(stars) as avgStars
    from movie m natural join rating
    group by m.mid;
select title, avgStars
from movieAvgRating
order by avgStars desc, title;

#3.	Find the names of all reviewers who have contributed three or more ratings.
select name
from rating natural join reviewer
group by rating.rid
having count(mid) >= 3;

#4. The same as 3 but try writing the query without HAVING or without COUNT.
select distinct name
from (reviewer natural join rating r1) join rating r2 join rating r3
	on r1.rid = r2.rid and r2.rid = r3.rid
		and (r1.mid != r2.mid or r1.stars != r2.stars)
        and (r1.mid != r3.mid or r1.stars != r3.stars)
        and (r3.mid != r2.mid or r3.stars != r2.stars);

/*5. Some directors directed more than one movie. For all such directors, return the titles of
all movies directed by them, along with the director name. Sort by director name, then movie title. */

select title, movie.director
from movie natural join
			(select director 
				from movie group by director 
                having count(mid) > 1) as temp
order by movie.director, title;

#6. Find the movie(s) with the highest average rating. Return the movie title(s) and average rating.
select *
from movieAvgRating
where avgStars = (select max(avgStars) from movieAvgRating );

#7. Find the movie(s) with the lowest average rating. Return the movie title(s) and average rating.
select *
from movieAvgRating
where avgStars = (select min(avgstars) from movieavgrating);

/*8. For each director, return the director's name together with the title(s) of the movie(s) they
directed that received the highest rating among all of their movies, and the value of that
rating. Ignore movies whose director is NULL. */

create view directorHighStar as
	(select director, max(avgStars) as maxstars
		from movieAvgRating
        group by director);
    
select director, title, avgStars
from movieAvgRating
where (director, avgStars) in (select director, maxstars
								from directorHighStar)
							and not isnull(director);

/*9. For each movie that has at least one rating, find the highest number of stars that movie
received. Return the movie title and number of stars. Sort by movie title. */

select mid, title, Highstars
from movie natural join 
	(select mid, max(stars) as Highstars
		from rating
        group by mid) as temp
order by title;

/*10. For each movie, return the title and the 'rating spread', that is, the difference between
highest and lowest ratings given to that movie. Sort by rating spread from highest to lowest, then by movie title. */

select mid, title, max(stars) - min(stars) as ratingSpread
from movie natural join rating
group by mid
order by ratingSpread desc, title;

