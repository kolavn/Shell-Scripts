#!/bin/bash

##### This code is to add for loops to install every package instead of writing manually.

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
N="\e[0m"

CHECK_ROOT(){
    if [ $USERID -ne 0 ]
    then
        echo "Please run this script with root priveleges"
        exit 1
    fi
}

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 is...$R FAILED $N"
        exit 1
    else 
        echo -e "$2 is...$G SUCCESS $N"
    fi  
}

CHECK_ROOT

dnf list installed git


### This is for getting "sh 15-loops.sh git mysql nginx"
for package in $@  #$@ refers to all arguments passed into it
do
    echo $package

done