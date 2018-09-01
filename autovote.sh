#!/bin/bash

### autovote.sh ### 
# courtesy of baryon.network 20180831
# free to edit and redistribute
# to avoid placing your signature passpharasse in a file this script will prompt you for passphrase
# update --from={your validator key wallet} befor running
# sugested to run this script inside of a screen session 
###


read -s -p "Enter Passphrase: " passphrase
echo ""

current_proposal=$(gaiacli gov query-proposals | tail -n 1 | cut -d'-' -f1)
known_proposal=$current_proposal

while true
 do
    current_proposal=$(gaiacli gov query-proposals | tail -n 1 | cut -d'-' -f1)
    if [ "$current_proposal" != "$known_proposal" ]
     then
        echo ""
        echo $(date +"%Y%m%d-%H:%M:%S") " New Proposal $current_proposal"
        echo "Voting Yes on your behalf, since this is only testnet."
        proposal_id=${current_proposal//[[:blank:]]/}
        echo  $passphrase|gaiacli gov vote --proposal-id=$proposal_id --option=Yes --from={your validator key wallet} --chain-id=gaia-8001

        known_proposal=$current_proposal
     else
            echo -n "."
    fi
    sleep 11s
 done
