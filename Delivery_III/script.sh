#!/bin/zsh

#CREATE="criar.sql"
#POPULATE="povoar.sql"


#COMMAND="cat $CREATE $POPULATE int*"

#$COMMAND | sqlite3 | grep "ERROR:"

for NUMBER in {1..10}
do
	cat criar.sql povoar.sql int$NUMBER.sql | sqlite3 | grep "ERROR:" 
done


for TRIG in {1..3} 
do 
	echo TRIGGER\_$TRIG
	cat criar.sql povoar.sql Trigger$TRIG/gatilho$TRIG\_adiciona.sql Trigger$TRIG/gatilho$TRIG\_verifica.sql Trigger$TRIG/gatilho$TRIG\_remove.sql | sqlite3 

done