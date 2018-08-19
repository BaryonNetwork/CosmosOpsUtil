#!/bin/bash

#########################
### Block Check Utility for Cosmos Network blockchain fullnodes and validators
### compliments of baryon.network
### takes two parameters block and ValidatorAddress
### defaults to ValidatorAddress 3AAD96F8B01F73344079C1D030B7AF5351BF9C11
### example Block Check Utility script call
### ./blockcheck.sh 106733 3AAD96F8B01F73344079C1D030B7AF5351BF9C11
###
### convenient alias installation:
### echo 'alias bc="~/blockcheck.sh"'>>~/.bash_profile
### source ~/.bash_profile
### call in a loop from your terminal example:
### while true; do bc 106733 3AAD96F8B01F73344079C1D030B7AF5351BF9C11; sleep 2; done
#########################


block=${1:-DEFAULTVALUE}
vaddr=${2:-3AAD96F8B01F73344079C1D030B7AF5351BF9C11}

urlstr='http://localhost:26657/commit?height='$block

commitEndpoint=$(curl -s $urlstr)
if [ -z "$commitEndpoint" ]
  then
    echo ''
    echo -n $(date +"%Y%m%d%H%M%S") ' '
    echo " *** ALERT! No response from endpoint ***"
    echo " *** $urlstr ***"
  else
    vCheck=$(echo $commitEndpoint|grep $vaddr)
    if [ -z "$vCheck" ]
    then
      echo "$vaddr MISSED COMMIT BLOCK $block"
    else
      echo "$vaddr present for $block"
   fi
fi

