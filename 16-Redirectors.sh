#!/bin/bash

# Program to create a folder for shell-script logs in /var/logs/shell-scripts/16-Redirectors.sh-<timestamp>.log

# Logs are important as to know what's the status of any action Succes/Failure.

# By creating this folder we can know when we ran the script &  whats the output, what's the error in the code

### echo "16-Redirectors.sh" | cut -d "." -f1   or  echo "$0" | cut -d "." "-f1"

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(echo "$0" | cut -d "." "-f1")
TIME_STAMP=$(date +%Y-%m-%d-%H-%S)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIME_STAMP.log" 

mkdir -p $LOGS_FOLDER
 
USERID=$(id -u)
R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

CHECK_ROOT(){
    if [ $USERID -ne 0 ]
    then
        echo -e "$R Please run this script with root priveleges $N" | tee -a $LOG_FILE
        exit 1
    fi
}

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 is...$R FAILED $N" | tee -a $LOG_FILE
        exit 1
    else 
        echo -e "$2 is...$G SUCCESS $N" | tee -a $LOG_FILE
    fi  
}

USAGE(){
    echo -e " $R USAGE::$N sudo sh 16-redirectors.sh package1 package 2.."
    exit 1
}

echo "Script started executing at : $(date)" | tee -a $LOG_FILE 

CHECK_ROOT

if [ $# -eq 0 ]
then
    USAGE
fi



for package in $@  #$@ refers to all arguments passed into it
do
    dnf list installed $package $LOG_FILE 
    if [ $? -ne 0 ]
    then 
        echo "$package is not installed, going to install it..." | tee -a $LOG_FILE
        dnf install $package -y
        VALIDATE $? "Installing $package"
    else
        echo -e "$package is already $Y insatlled..nothing to do $N" | tee -a $LOG_FILE
    fi

done