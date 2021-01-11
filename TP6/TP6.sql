use movierating;

#1	Find the titles of all movies directed by “Steven Spielberg”.
select title
from movie
where director = "Steven Spielberg";

#2	Find all years that have a movie that received a rating of 4 or 5, and sort them in increasing order.
select distinct year
from movie join rating
where stars = 4 or stars = 5
order by year;
    
#3	Find the titles of all movies that have no ratings.
select title
from movie
where mid not in (select distinct mid from rating);

#4	Some reviewers didn't provide a date with their rating. Find the names of all reviewers who have ratings with a NULL value for the date.
select name
from reviewer natural join rating
where isnull(ratingdate);

/* 5 Write a query to return the ratings data in a more readable format: reviewer name, movie
title, stars, and ratingDate. Also, sort the data, first by reviewer name, then by movie title,
and lastly by number of stars. */

select name, title, stars, ratingdate
from movie natural join rating natural join reviewer
order by name, title, stars;

#6	Find the names of all reviewers who rated “Gone with the Wind”.
select distinct name
from reviewer natural join rating natural join movie
where title = "Gone with the Wind";

#7	For any rating where the reviewer is the same as the director of the movie, return the reviewer name, movie title, and number of stars.
select name, title, stars
from movie natural join rating natural join reviewer
where director = name;

#8	Return all reviewer names and movie names together in a single list, alphabetized.
select name as c1
from reviewer
	union
select title as c1
from movie 
order by c1;

#9	Find the titles of all movies not reviewed by “Chris Jackson”.
select title 
from movie
where mid not in (select mid
					from rating natural join reviewer
                    where name = "Chris Jackson" );

/*10	For all pairs of reviewers such that both reviewers gave a rating to the same movie, return
the names of both reviewers. Eliminate duplicates, don't pair reviewers with themselves,
and include each pair only once. For each pair, return the names in the pair in alphabetical order.	*/

create view rating_reviewer as select name, rid, mid, stars
								from rating natural join reviewer;

select distinct r1.name as reviewer1, r2.name as reviewer2
from rating_reviewer as r1 join rating_reviewer as r2
	on r1.mid = r2.mid and r1.name < r2.name
order by reviewer1;
