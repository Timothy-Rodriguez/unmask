#!/bin/bash

echo ""
echo -e "\e[5m\e[92m\e[1m    ██╗   ██╗███╗   ██╗███╗   ███╗ █████╗ ███████╗██╗  ██╗\e[0m"
echo -e "\e[5m\e[92m\e[1m    ██║   ██║████╗  ██║████╗ ████║██╔══██╗██╔════╝██║ ██╔╝\e[0m"
echo -e "\e[5m\e[92m\e[1m    ██║   ██║██╔██╗ ██║██╔████╔██║███████║███████╗█████╔╝ \e[0m"
echo -e "\e[5m\e[92m\e[1m    ██║   ██║██║╚██╗██║██║╚██╔╝██║██╔══██║╚════██║██╔═██╗ \e[0m"
echo -e "\e[5m\e[92m\e[1m    ╚██████╔╝██║ ╚████║██║ ╚═╝ ██║██║  ██║███████║██║  ██╗\e[0m"
echo -e "\e[5m\e[92m\e[1m     ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝\e[0m"
echo ""
echo -e "\e[92m\e[1m                                                 -v1.0\e[0m"
echo ""
echo -e "\e[92m\e[1m                            -Made with <3 by Rodriguez\e[0m"

                                     
while getopts f: aflag; do
	case $aflag in
		f) while IFS=' ' read -r line
			
			do
				wget -q --tries=10 --timeout=20 --spider https://www.google.com
				if [[ $? -eq 0 ]]; then
					
				        val=$(timeout 5 curl -I "$line" 2>&1 | awk '/HTTP\// {print $2}')
	
					if [[ "$val" -eq '404.txt' ]];
					then
					echo -e "\e[92m\e[1m$line\e[0m"
					echo -e "[*]$line" >> main.txt
					echo -e "[*]$line" >> 404.txt
					echo "   Response code : $val" | tee -a main.txt 404.txt
					echo "   Host Lookup: "
					h=$(host $line)
					echo "$h" | sed 's/^/   /' | tee -a main.txt 404.txt
					cname=$(dig $line CNAME | sed '14,14!d' | awk '{ print $5 " " $6 " " $7 " " $8}')
					echo "   CNAME : $cname" | tee -a main.txt 404.txt
					nx=$(dig $line CNAME | sed '5,5!d' | awk '{ print $5 $6}' | tr ',' ' ')
					echo "  $nx" | tee -a main.txt 404.txt
					printf "\n" | tee -a main.txt 404.txt	
					sleep 0.2			
	
	
					elif [[ "$val" -ge '400.txt' && "$val" -le '469' ]];
					then
					echo -e "\e[92m\e[1m$line\e[0m"
					echo -e "[*]$line" >> main.txt
					echo -e "[*]$line" >> 400.txt
					echo "   Response code : $val" | tee -a main.txt 400.txt
					echo "   Host Lookup: "
					h=$(host $line)
					echo "$h" | sed 's/^/   /' | tee -a main.txt 400.txt
					cname=$(dig $line CNAME | sed '14,14!d' | awk '{ print $5 " " $6 " " $7 " " $8}')
					echo "   CNAME : $cname"
					nx=$(dig $line CNAME | sed '5,5!d' | awk '{ print $5 $6}' | tr ',' ' ')
					echo "$nx" | tee -a main.txt 400.txt
					printf "\n" | tee -a main.txt 400.txt
					sleep 0.2
					
					elif [[ -z $val ]]
					then
					echo -e "\e[91m\e[1m$line\e[0m"
					echo -e "[*]$line" >> main.txt
					echo -e "[*]$line" >>  timeout.txt
					echo "   ***Timeout***" | tee -a main.txt 
					echo "" | tee -a main.txt
					sleep 0.2
	
					else
					echo -e "\e[96m\e[1m$line\e[0m"
					echo -e "[*]$line" >> main.txt
					echo -e "[*]$line" >> other_status_code.txt
					echo "   Response code : $val" | tee -a main.txt other_status_code.txt
					cname=$(dig $line CNAME | sed '14,14!d' | awk '{ print $5 " " $6 " " $7 " " $8}')
					echo "   CNAME : $cname" | tee -a main.txt other_status_code.txt
					echo "   Host Lookup: "
					h=$(host $line)
					echo "$h" | sed 's/^/   /' | tee -a main.txt other_status_code.txt
					nx=$(dig $line CNAME | sed '5,5!d' | awk '{ print $5 $6}' | tr ',' ' ')
					echo "    $nx" | tee -a main.txt other_status_code.txt
					printf "\n" | tee -a main.txt other_status_code.txt
					sleep 0.2
					fi
        

				else
					echo '---No internet connection.---'
					echo "Last site RECON :$line"
					exit
        
				fi

					
					
				

				
			done < $OPTARG;;
		
		*) echo "Available option: -f file"
	esac
done