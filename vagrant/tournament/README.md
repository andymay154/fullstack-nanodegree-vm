# Swiss Style Tournament API

This project cosists of a tournament.sql file to prepare a database and a tounament.py file to enable the connections to the database. The goal of this  project is to facilitate a swiss style tournament game.

## Getting Started

You will need to access a PSQL database in order to run the tournament.sql file and prepare the database. From the PSQL commant promptou are located in the directory containing the tournament sql and tournament.py files, then input `\i tournament.sql`. This will create the necessary database and views.

You can then call the functions available within the tournament.py python file, which is written in Python version 2.7.

## Usage

There are *eight* functions within the tournament.py file as follows:

* **connect()**: _Connects to the database prepared by the tournament.sql file_
* **deleteMatches()**: _Remove all the match records from the database._
* **deletePlayers()**: _Remove all the player records from the database._
* **countPlayers()**: _Returns the number of players currently registered_
* **registerPlayer(name)**: _Adds a player to the tournament database. Args: name= the player's full name (need not be unique)_
* **playerStandings()**: _Returns a list of the players and their win records, sorted by wins_
* **reportMatch(winner, loser)**: _Records the outcome of a single match between two players. Args: winner= the id number of the player who won, loser=  the id number of the player who lost_
* **swissPairings()**: _Returns a list of pairs of players for the next round of a match_


# Database structure

The database is called *tournament* and consists of the following:

### Tables

* **Players**
    - _playerid
    - name_

* **Matches** 
    - matchid
    - winner
    - loser_

### Views

There are some SQL views in the database to provide the data for the Python functions.

* **Matches_Played**: _Returns the total number of matches played by each player_
* **Player_Standings**: _Returns the total number of matches played AND number of wins for each player_
* **swissPairings**: _Provides the game pairings throughout a tournament_


