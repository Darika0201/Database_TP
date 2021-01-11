
USE movierating; 

-- 1. Find the titles of all movies directed by “Steven Spielberg”.

SELECT title
FROM Movie
WHERE director = 'Steven Spielberg';

-- 2. Find all years that have a movie that received a rating of 4 or 5, and sort them in increasing order.

SELECT DISTINCT year
FROM Movie
	INNER JOIN Rating 
		USING(mID)
	WHERE stars IN (4, 5)
	ORDER BY year;

-- 3. Find the titles of all movies that have no ratings.

SELECT title
FROM Movie
WHERE mID 
NOT IN	(SELECT mID 
			FROM Rating);

-- 4. Some reviewers didn't provide a date with their rating. Find the names of all reviewers who have ratings with a NULL value for the date.

SELECT name
FROM Reviewer
INNER JOIN Rating 
		USING(rID)
	WHERE ratingDate IS NULL;

-- 5. Write a query to return the ratings data in a more readable format: reviewer name, movie title, stars, and ratingDate. Also, sort the data, first by reviewer name, then by movie title,and lastly by number of stars.

SELECT name, title, stars, ratingDate
FROM Movie, Rating, Reviewer
	WHERE 
		Movie.mID = Rating.mID 
			AND 
		Reviewer.rID = Rating.rID
	ORDER BY name, title, stars;

-- 6. Find the names of all reviewers who rated “Gone with the Wind”.

SELECT DISTINCT name
FROM Movie
INNER JOIN Rating 
		USING(mId)
INNER JOIN Reviewer 
		USING(rId)
	WHERE title = "Gone with the Wind";

-- 7. For any rating where the reviewer is the same as the director of the movie, return the reviewer name, movie title, and number of stars.

SELECT name, title, stars
FROM Movie
INNER JOIN Rating 
		USING(mID)
INNER JOIN Reviewer 
		USING(rID)
	WHERE director = name;

-- 8. Return all reviewer names and movie names together in a single list, alphabetized.

SELECT title 
FROM Movie
	UNION
SELECT name 
FROM Reviewer
ORDER BY name, title;

-- 9. Find the titles of all movies not reviewed by “Chris Jackson”.

SELECT title
FROM Movie
WHERE mId NOT IN (SELECT mID
					FROM Rating
					INNER JOIN Reviewer 
							USING(rID)
					WHERE name = "Chris Jackson");

-- 10. For all pairs of reviewers such that both reviewers gave a rating to the same movie, return the names of both reviewers. 
-- Eliminate duplicates, don't pair reviewers with themselves,and include each pair only once. 
-- For each pair, return the names in the pair in alphabetical order.

SELECT DISTINCT Re1.name AS reviewer1_name, Re2.name AS reviewer1_name
FROM Rating AS R1, Rating AS R2, Reviewer AS Re1, Reviewer AS Re2
WHERE	R1.mID = R2.mID
			AND 
		R1.rID = Re1.rID
			AND 
		R2.rID = Re2.rID
			AND 
		Re1.name < Re2.name
	ORDER BY Re1.name, Re2.name;
  