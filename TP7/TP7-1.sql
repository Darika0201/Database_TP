
USE movierating; 

-- 1. For each rating that is the lowest (fewest stars) currently in the database, return the reviewer name, movie title, and number of stars.

SELECT name, title, stars
FROM Movie
	INNER JOIN Rating 
					USING(mID)
	INNER JOIN Reviewer
					USING(rID)
	WHERE stars = (SELECT MIN(stars)
						FROM Rating);
                    
-- 2. List movie titles and average ratings, from highest-rated to lowest-rated. 
-- If two or more movies have the same average rating, list them in alphabetical order.

SELECT title, AVG(stars) AS average
FROM Movie
	INNER JOIN Rating
					USING(mID)
	GROUP BY mID
	ORDER BY average DESC, title;

-- 3. Find the names of all reviewers who have contributed three or more ratings.

SELECT name
FROM Reviewer
	INNER JOIN Rating 
					USING(rID)
	GROUP BY rID
	HAVING COUNT(*) >= 3;

-- 4. The same as 3 but try writing the query without HAVING or without COUNT.

SELECT name
FROM Rating AS r1 JOIN Rating AS r2 JOIN Rating AS r3
ON r1.rID = r2.rID AND r2.rID = r3.rID
AND (r1.mID != r2.mID OR r1.stars != r2.stars) # <=> (r1.mID, r1.stars) != (r2.mID, r2.stars)
AND (r1.mID != r3.mID OR r1.stars != r3.stars)
AND (r3.mID != r2.mID OR r3.stars != r2.stars);

-- 5. Some directors directed more than one movie. For all such directors, return the titles of all movies directed by them, 
-- along with the director name. Sort by director name, then movie title.

SELECT M1.title, director
FROM Movie AS M1
	INNER JOIN Movie AS M2 
						USING(director)
	GROUP BY M1.mID
	HAVING COUNT(*) > 1
	ORDER BY director, M1.title;

-- 6. Find the movie(s) with the highest average rating. Return the movie title(s) and average rating.

SELECT title, AVG(stars) AS average
FROM Movie
	INNER JOIN Rating 
					USING(mID)
		GROUP BY mID
		HAVING average = (SELECT MAX(average_stars)
								FROM (SELECT title, AVG(stars) AS average_stars
									FROM Movie 
									INNER JOIN Rating 
													USING(mID)
		GROUP BY mID));

-- 7. Find the movie(s) with the lowest average rating. Return the movie title(s) and average rating.

SELECT title, AVG(stars) AS average
	FROM Movie INNER JOIN Rating
								USING(mID)
GROUP BY mID
HAVING average = (SELECT MIN(average_stars)
	FROM (SELECT title, AVG(stars) AS average_stars
			FROM Movie INNER JOIN Rating 
										USING(mID)
GROUP BY mID));

-- 8. For each director, return the director's name together with the title(s) of the movie(s) 
-- they directed that received the highest rating among all of their movies, and the value of that rating. 
-- Ignore movies whose director is NULL.

SELECT director, title, MAX(stars)
	FROM Movie 
    INNER JOIN Rating 
					USING(mID)
	WHERE director IS NOT NULL
	GROUP BY director;

-- 9. For each movie that has at least one rating, find the highest number of stars that movie received. 
-- Return the movie title and number of stars. Sort by movie title.

SELECT title, MAX(stars)
FROM Movie
	INNER JOIN Rating 
					USING(mID)
	GROUP BY mID
	ORDER BY title;

-- 10.For each movie, return the title and the 'rating spread', that is, 
-- the difference between highest and lowest ratings given to that movie. 
-- Sort by rating spread from highest to lowest, then by movie title.

SELECT title, (MAX(stars) - MIN(stars)) AS rating_spread
FROM Movie
	INNER JOIN Rating 
					USING(mID)
	GROUP BY mID
	ORDER BY rating_spread DESC, title;
