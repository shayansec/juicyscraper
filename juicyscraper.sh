#!/bin/bash

file=$2

if [[ $1 = "-f" ]]; then
    while read domain; do
    	# gettings robots.txt files of domains
    	python getrobo.py $domain

    	while read line; do

    		# filtering the content to show only disallowed path

    		if [[ $line == *"Disallow"* ]]; then
                echo $line | cut -d " " -f2 >> path_$domain
            fi

    	done < $domain

        if [[ -f path_$domain ]]; then
            cat path_$domain | sort -u > final_$domain

            rm path_$domain

            mv final_$domain $domain

            sed -i "s/^/$domain/" $domain
        else
            echo "No Disallow path exist on $domain"
            rm $domain
        fi

    done < $2

elif [[ $1 = "-h" ]]; then
    echo "[+] Usage: ./juicyscraper.sh -d domain_file"
    echo "[+] domain_file should contain domains(e.g. httpbin.org) in each line."

elif [[ !$1 ]]; then
    echo "
  o     o  _     _  _ ._ _. ._  ._   _  ._
  | |_| | (_ \/ _> (_ | (_| |_) |_) (/_ |
 _|          /              |   |          "

    echo "Use -h for help..."
fi
