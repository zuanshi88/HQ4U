#!/bin/bash 


echo "checking status"

`git status`

echo "Proceed?"

read=response

if response = "n"   
    echo "Aborting"
    exit
else 

    `git add .`
fi 

echo "Ready to commit"