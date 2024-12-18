#!/bin/bash

COL='\033[1;33m'
WHITE='\033[1;37m'


eval "$(ssh-agent -s)"

clear

echo -e "${COL}
                 %%%%%                        %%%%%                        
                 %%%%%%%%               %%%%%%%%%%%%%%%%                   
                 %%%%%%%%%%          %%%%%%%%%%%%%%%%%%%%%%                
                 %%%%%%%%%         %%%%%%%%%%%%%%%%%%%%%%%%%%              
                  %%%%%%%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%             
                   %%%%%%        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            
                    %%%%        %%%%%%%%%%%          %%%%%%%%%%%           
                      %%%       %%%%%%%%%%             %%%%%%%%%%          
                     %%%%%%    %%%%%%%%%%              %%%%%%%%%%          
                    %%%%%%%%   %%%%%%%%%                %%%%%%%%%          
                   %%%%%%%%%%  %%%%%%%%%                %%%%%%%%%          
                  %%%%%%%%%%%   %%%%%%%%%              %%%%%%%%%%          
                  %%%%%%%%%%%   %%%%%%%%%%            %%%%%%%%%%           
                 %%%%%%%%%%%     %%%%%%%%%%%%%    %%%%%%%%%%%%%%           
                %%%%%%%%%%%%      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%            
               %%%%%%%%%%%%        %%%%%%%%%%%%%%%%%%%%%%%%%%              
               %%%%%%%%%%%          %%%%%%%%%%%%%%%%%%%%%%%%               
                 %%%%%%%%             %%%%%%%%%%%%%%%%%%%%                 
                      %%                  %%%%%%%%%%%%                     
${WHITE}"
echo -n "Please enter key name: "
read key
printf "Please enter your email-adress:"
read email


ssh-keygen -t rsa -b 8192 -C "$email" -f ~/.ssh/$key

clear

FILE=~/.ssh/config
if [ -f "$FILE" ]; then
	# add line to the config file
	echo "Host *
	AddKeysToAgent yes
	UseKeychain yes
	IdentityFile ~/.ssh/$key" >> ~/.ssh/config
else 
	printf "$FILE created and $key added to ssh store for persistency"
	echo "Host *
	AddKeysToAgent yes
	UseKeychain yes
	IdentityFile ~/.ssh/$key" > ~/.ssh/config
fi

printf "$key Key added to $FILE for persistency.\n\n"

printf "Please add this public key to your git account or in bridge:\n\n"
echo "-----BEGIN SSH2 PUBLIC KEY-----"
cat ~/.ssh/$key.pub
echo "-----END SSH2 PUBLIC KEY-----"
printf "\n\n"


ssh-add ~/.ssh/$key
