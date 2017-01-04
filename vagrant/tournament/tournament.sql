-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

DROP database IF EXISTS tournament;

CREATE database tournament;

\c tournament;

CREATE TABLE Players (playerid SERIAL PRIMARY KEY, name VARCHAR(40));

CREATE TABLE Matches (matchid SERIAL PRIMARY KEY, winner SMALLINT REFERENCES Players(playerid) , loser SMALLINT REFERENCES Players(playerid));


-- Create a view in the database to list the total number of matches played by each player.
CREATE VIEW Matches_Played AS 
SELECT player, SUM(playermatches) matches
FROM (
SELECT winner player, COUNT(winner) playermatches FROM Matches GROUP BY winner 
UNION ALL 
SELECT loser player, COUNT(loser) playermatches FROM Matches GROUP BY loser) 
counttable 
GROUP BY player;


-- Create a view in the database to provide an up to date list of the total number of matches played and wins for each player.
CREATE VIEW Player_Standings AS 
SELECT id, name, wins, COUNT(MP.matches)  matches
FROM 
(
SELECT playerid id, name, COUNT(winner) wins--M.wins--, MP.matchesplayed 
FROM Players 
LEFT JOIN Matches
ON Players.playerid = Matches.winner
GROUP BY playerid, name
) T
LEFT JOIN Matches_Played MP ON T.id = MP.player
GROUP BY id, name, wins
ORDER BY wins DESC;


-- Create a view in the database to provide the game pairings throughout a tournament.
CREATE VIEW swissPairings AS
SELECT a.id id1, a.name name1, b.id id2, b.name name2
FROM 
(
-- use the sql row function to create a unique row number for every row in the table.
SELECT ROW_NUMBER() over (ORDER BY wins) rowNumber, id, name
FROM Player_Standings
) a
LEFT JOIN
(
SELECT ROW_NUMBER() over (ORDER BY wins) rowNumber, id, name
FROM Player_Standings
) b
-- Add 1 to the left hand table row numbers and join it to the row numbers on the right hand table.
ON a.rowNumber+1 = b.rowNumber 
-- Use the Modulo function to divide row number by two and select only those where the remainder is 0, therby eliminating the odd numbered rows.
WHERE b.rowNumber % 2 =0



