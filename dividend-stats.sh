#!/bin/sh

if test $# -lt 2
then
   echo "usage: $0 <op-txn-history.csv> <plain | csv>"
   exit 1
fi

# Developer : Surinder Kumar 
#
# Login to icici bank account using net banking
# My accounts -> Bank Accounts -> View Detailed Statement
# Transaction Date from ... maximum 1 year period
# Advanced Search : Transaction Type : Credit
# Get Statement
# Download details as XLS file
# Save it as OpTransactionHistory.xls
# Open it and remove lines till line # 12 'Transactions list' 
# Save it as op-txn-history.csv 

DIV_FILE=$1
CSV_OUT=$2

if [[ $CSV_OUT == "csv" ]] 
then

    echo "Date, Company, Dividend"
    cat $DIV_FILE | grep -v -e NEFT -e CASH -e "Int\.Pd" | grep -e ACH -e CMS -e APBS | grep -v -e BLPGCM | sed -e s'/Limited,\//Limited\//g' | sed -e 's/\"//g' | awk -F',' '{ tdate=$3; tcomp=$6; damount=$8; split(tcomp, comp_name, "/"); company = comp_name[2]; printf("%s,%s,%s\n", tdate, company, int(damount)); }' 

else

    echo "Date Company Dividend "
    cat $DIV_FILE | grep -v -e NEFT -e CASH -e "Int\.Pd" | grep -e ACH -e CMS -e APBS | grep -v -e BLPGCM | sed -e s'/Limited,\//Limited\//g' | sed -e 's/\"//g' | awk -F',' '{ tdate=$3; tcomp=$6; damount=$8; split(tcomp, comp_name, "/"); company = comp_name[2]; printf("%s %s %s\n", tdate, company, int(damount)); }' 

fi
