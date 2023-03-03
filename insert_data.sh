#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

echo $($PSQL "TRUNCATE TABLE games, teams;")

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  
  # echo $YEAR, $ROUND, $WINNER, $OPPONENT, $WINNER_GOALS, $OPPONENT_GOALS

  if [[ $WINNER != 'winner' ]]
  then
    #get team name
    TEAM_NAME_W=$($PSQL "SELECT name FROM teams WHERE name='$WINNER'")
    
    #if not found
    if [[ -z $TEAM_NAME_W ]]
    then
      #insert team
      INSERT_TEAM_NAME_W=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
      
      #get new team name 
      TEAM_NAME_W=$($PSQL "SELECT name FROM teams WHERE name='$WINNER'")
    fi
  fi
  if [[ $OPPONENT != 'opponent' ]]
  then
    #get team name
    TEAM_NAME_O=$($PSQL "SELECT name FROM teams WHERE name='$OPPONENT'")
    
    #if not found
    if [[ -z $TEAM_NAME_O ]]
    then
      #insert team
      INSERT_TEAM_NAME_O=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
      
      #get new team name 
      TEAM_NAME_O=$($PSQL "SELECT name FROM teams WHERE name='$OPPONENT'")
    fi
  fi
  
done

echo $($PSQL "SELECT * FROM teams;")
