#!/bin/bash

################################
### Scripted by Baryon.Network for Cosmos.Network ops monitoring
### This utility is good for keeping ssh terminal sessions active
### Provides gaiad response confirmation in default of 11 second increments
### accepts one parameter for sleep seconds for the loop.
### convenient alias installation:
### echo 'alias o="~/orbit.sh"'>>~/.bash_profile
### source ~/.bash_profile
################################

timer=${1:-11}
i=0

while true
  do echo -n $i ' '
    let i=i+1
    echo -n $(date +"%Y%m%d%H%M%S") ' '&&gaiacli status|awk -F , '{printf $15}'|sed 's/"//g'
    curl -s http://localhost:26657/net_info|grep n_peer|sed 's/",//g'|sed 's/"//g'
  sleep $timer
done
