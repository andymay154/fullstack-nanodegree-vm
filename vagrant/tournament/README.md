# Swiss Style Tournament API

This project cosists of a tournament.sql file to prepare a database and a tounament.py file to enable the connections to the database. The goal of this  project is to facilitate a swiss style tournament game.

## Getting Started

You will need to access a PSQL database in order to run the tournament.sql file and prepare the database.

The tournament.py file is written in Python 2.7, so you may first need to install that.

## Usage

There are *eight* functions within the tournament.py file as follows:

* connect(): _Connects to the database prepared by the tournament.sql file_
* deleteMatches(): _Remove all the match records from the database._
* deletePlayers(): _Remove all the player records from the database._
* countPlayers(): _Returns the number of players currently registered_
* registerPlayer(name): _Adds a player to the tournament database. Args: name= the player's full name (need not be unique)_
* playerStandings(): _Returns a list of the players and their win records, sorted by wins_
* reportMatch(winner, loser): _Records the outcome of a single match between two players. Args: winner= the id number of the player who won, loser=  the id number of the player who lost_
* swissPairings(): _Returns a list of pairs of players for the next round of a match_

