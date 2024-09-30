#!/bin/bash

USERID=$(id -u)

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo "$1 is....Failed"
        exit 1
    else
        echo "$2 is ....SUCCESS
}

VALIDATE $1 "mysql installation"

if [ $USERID -eq 0 ]
then
    dnf list installed mysql
    if [ $? -eq 0 ]
    then
        echo "The package is already installed, Please proceed".
        exit 1
    else
        echo "Going to Install mysql"
        dnf install mysql -y 
    fi
else
    echo "The user doesn't have root access. Please try with root access"
    exit 1
fi

