#*********PART 1***********

#-----Question 1-----
SELECT COUNT(DISTINCT tailnum) AS 'No. listed speeds',
MAX(speed) AS 'Max. speed',
MIN(speed) AS 'Min. speed'
FROM planes
WHERE speed IS NOT null;
#Output: 23, 432, 90

#-----Question 2-----
SELECT SUM(distance)
FROM flights
WHERE year = 2013
AND month = 1;
#Output: 27188805

SELECT SUM(distance)
FROM flights
WHERE year = 2013
AND month = 1
AND tailnum is null;
#OUtput: 81763

#-----Question 3-----
#Total distance flown INNER JOIN
SELECT p.manufacturer, SUM(f.distance)
FROM planes p
INNER JOIN flights f
ON p.tailnum = f.tailnum
WHERE f.year = 2013
AND f.month = 7
AND f.day = 5
GROUP BY p.manufacturer;

#Total distance flown LEFT OUTER JOIN
/*In this case, there was no difference between the outputs.
However, the login of the LEFT OUTER JOIN would also return
all records of the first field, regardless of whether or not
there are non-null records for the second specified field.
*/
SELECT p.manufacturer, SUM(f.distance)
FROM planes p
LEFT OUTER JOIN flights f
ON p.tailnum = f.tailnum
WHERE f.year = 2013
AND f.month = 7
AND f.day = 5
GROUP BY p.manufacturer;

#-----Question 4-----
/*This query lists the average arrival delay for American Airlines flights
at all destinations from New York airports in the month of July, 2013
listed from greatest to least delay.*/
SELECT f.month AS Month, AVG(f.arr_delay) AS 'Average arrival delay', ap.name AS 'Airport'
FROM flights as f
INNER JOIN airlines AS a
ON a.carrier = f.carrier
INNER JOIN airports AS ap
ON f.dest = ap.faa
WHERE f.month = 7
AND a.carrier = 'AA'
GROUP BY f.month, ap.name
ORDER BY AVG(f.arr_delay) DESC;

#**********PART 2**********
#URL TO PUBLIC TABLEAU WORKBOOK:
# https://public.tableau.com/profile/alexander.doler#!/vizhome/Comparisionofaverageflightdelays/Dashboard1

/*I am unable to export data into a .csv by query due to an Error 1290, which I am unable to resolve
However, the below is a query that I would use to export data into a .csv file
For this assignment, I impported the full .csv files in Tableau
*/

SELECT f.month AS Month, AVG(f.dep_delay) AS 'Average delay'
INTO OUTFILE '/Users/alexanderdoler/Desktop/CUNY\ Spring\ 2017/IS\ 362/Assignments/Week\ 1/avgDelayJFK.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\n'
FROM flights as f
INNER JOIN airlines AS a
ON a.carrier = f.carrier
WHERE f.origin = 'JFK'
AND a.carrier = 'AA'
GROUP BY f.month
ORDER BY month;

SELECT f.month AS Month, AVG(f.dep_delay) AS 'Average delay'
INTO OUTFILE '/Users/alexanderdoler/Desktop/CUNY\ Spring\ 2017/IS\ 362/Assignments/Week\ 1/avgDelayMIA.csv'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
ESCAPED BY '\\'
LINES TERMINATED BY '\n'
FROM flights as f
INNER JOIN airlines AS a
ON a.carrier = f.carrier
WHERE f.origin = 'LGA'
AND a.carrier = 'DL'
GROUP BY f.month
ORDER BY month DESC;
