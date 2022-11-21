#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements")
for i in $ATOMIC_NUMBER
do
	if [[ $i == $1 ]]
	then 
		ATOMIC_NUMBER=$i
	fi
done
SYMBOL=$($PSQL "SELECT symbol FROM elements")
for i in $SYMBOL
do
	if [[ $i == $1 ]]
	then
		SYMBOL=$i
	fi
done
NAME=$($PSQL "SELECT name FROM elements")
for i in $NAME
do
	if [[ $i == $1 ]]
	then
		NAME=$i
	fi
done

if [[ -z $1 ]]
then
	echo Please provide an element as an argument.

elif [[ $ATOMIC_NUMBER == $1 ]]
then
	ELEMENT=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties  USING (atomic_number) INNER JOIN types USING (type_id) WHERE atomic_number = $ATOMIC_NUMBER")
	echo $ELEMENT | while IFS='|' read ATOMIC_NUMBER NAME SYMBOL TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT
do
	echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
done

elif [[ $NAME == $1 ]]
then 
	ELEMENT=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties  USING (atomic_number) INNER JOIN types USING (type_id) WHERE name = '$NAME'")

	echo $ELEMENT | while IFS='|' read ATOMIC_NUMBER NAME SYMBOL TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT
do
	echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
done

elif [[ $SYMBOL == $1 ]]
then
	ELEMENT=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties  USING (atomic_number) INNER JOIN types USING (type_id) WHERE symbol = '$SYMBOL'")

	echo $ELEMENT | while IFS='|' read ATOMIC_NUMBER NAME SYMBOL TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT
do
	echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
done

else
	echo I could not find that element in the database.

fi