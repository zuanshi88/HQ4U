#!/bin/bash 


echo "checking status"

git status

echo "Proceed?"

read=response

if response = "n"   
    then 
    echo "Aborting"
    exit
else
     git add .
fi 

echo "Message, por favor..."

read=RESPONSE

git commit -m '$RESPONSE'