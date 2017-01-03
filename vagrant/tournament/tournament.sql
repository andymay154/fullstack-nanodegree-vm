-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

drop database if exists tournament;

create database tournament;

\c tournament;

create table Players (playerid serial primary key, name varchar(40));

create table Matches (matchid serial primary key, winner smallint, loser smallint);


-- Create a view in the database to list the total number of matches played by each player.
create view Matches_Played as 
select player, sum(playermatches) matches
from (
select winner player, count(winner) playermatches from Matches group by winner 
union all 
select loser player, count(loser) playermatches from Matches group by loser) 
counttable 
group by player;


-- Create a vew in the database to provide an up to date list of the total number of matches played and wins for each player.
create view Player_Standings as 
select id, name, wins, count(MP.matches)  matches
from 
(
select playerid id, name, count(winner) wins--M.wins--, MP.matchesplayed 
from Players 
left join Matches
on Players.playerid = Matches.winner
group by playerid, name
) T
left join Matches_Played MP on T.id = MP.player
group by id, name, wins
order by wins desc;


-- Create a vew in the database to provide the game pairings throughout a tournament.
create view swissPairings as
select a.id id1, a.name name1, b.id id2, b.name name2
from 
(
-- use the sql row function to create a unique row number for every row in the table.
select row_number() over (order by wins) rowNumber, id, name
from Player_Standings
) a
left join
(
select row_number() over (order by wins) rowNumber, id, name
from Player_Standings
) b
-- Add 1 to the left hand table row numbers and join it to the row numbers on the right hand table.
on a.rowNumber+1 = b.rowNumber 
-- Use the Modulo function to divide row number by two and select only those where the remainder is 0, therby eliminating the odd numbered rows.
where b.rowNumber % 2 =0



