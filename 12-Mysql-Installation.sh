#!/bin/bash

USERID=$(id -u)

echo "User ID is $USERID"

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

systemctl status mysql

if [ $? -ne 0]
then 
    echo "There is error in installing package"
else
    echo "Package is installed"
fi