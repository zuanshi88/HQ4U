#!/bin/bash 


echo "checking status"

git status

read -p "Proceed?" RESPONSE



if RESPONSE == "n"   
    then 
    echo "Aborting"
    exit
else
     git add .
fi 

read -p "Message, por favor..." RESPONSE

git commit -m "$RESPONSE"