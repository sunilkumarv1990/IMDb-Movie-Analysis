use imdb_db;

WITH movie_details AS
(
select m.id, m.title, m.Year, m.country, m.languages, r.category, ra.avg_rating
from movie m
INNER JOIN role_mapping r  on m.id=r.movie_id
INNER JOIN ratings ra on ra.movie_id = m.id
)
select * from movie_details
limit 5;


select movie_id, avg_rating, 
RANK() over (order by avg_rating desc) as _Rank,  
DENSE_RANK () over (order by avg_rating desc) as DenseRank ,  
ROW_NUMBER() over (order by avg_rating desc) as RowNumber 
from ratings; 

DROP PROCEDURE Getmovies;

DELIMITER //
CREATE PROCEDURE GetMovies()
BEGIN
Select distinct (m.id), m.title, g.genre, ra.avg_rating from movie m
INNER JOIN genre g  on m.id=g.movie_id
INNER JOIN ratings ra on ra.movie_id = m.id
where ra.avg_rating >=7
order by ra.avg_rating DESC;
END //
DELIMITER ;

call GetMovies;

SELECT float_val,
CASE
    WHEN float_val > 5 THEN "The value is greater than 5"
    WHEN float_val = 5 THEN "The value is 5"
    ELSE "The value is under 5"
END as float_txt
FROM float01001;


SELECT distinct r.movie_id, m.title, g.genre, r.avg_rating,
CASE
	WHEN r.avg_rating >=8 THEN "Good_Movie"
    WHEN r.avg_rating >=6.5 THEN "Okie_movie"
    ELSE "Bad_Movie"
END as Movstatus
from ratings r
INNER JOIN genre g  on r.movie_id=g.movie_id
INNER JOIN movie m on r.movie_id = m.id
order by m.title;

Call GetMovies()
CASE
	WHEN avg_rating >=8 THEN "Good_Movie"
    WHEN avg_rating >=6.5 THEN "Okie_Movie"
    ELSE "Bad_Movie"
END as Movstatus;

SELECT OrderID, Quantity,
CASE
    WHEN Quantity > 30 THEN 'The quantity is greater than 30'
    WHEN Quantity = 30 THEN 'The quantity is 30'
    ELSE 'The quantity is under 30'
END AS QuantityText
FROM OrderDetails;
