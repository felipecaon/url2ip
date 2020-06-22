#!/bin/bash

dns_output="$1_ips.txt"

while IFS= read -r domain
do
  ip=$(dig "$domain" +short | grep -oP "([0-9]{1,3}\.){3}[0-9]{1,3}")
  echo $ip >> "temp.txt"
done < "$1"

cat "temp.txt" | awk '!seen[$0]++' | sort | tee -a $dns_output
rm "temp.txt"