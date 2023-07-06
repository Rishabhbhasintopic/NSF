#!/bin/bash

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
Magenta='\033[0;35m'
NC='\033[0m' # No color

echo -e "${CYAN}"
echo "                                                                                      
                      ..                                 . . .                  
      /      .,,,,,,,,,,,,,,,,,,,,,...,,,,,,,,,,,,,,,,. .  ####, .              
    .(#(   ##                                        ..##     ..       .        
           #.                                          ,#.  .    .              
           #.   #(///////////////////*//////////*/#/   ,#,.                     
          .#.   #*  .       .     .        .  .   #/   ,#.   .                  
          .#.   #*        . .      .         ..   #/ ..*#.   .                  
           #.   #*                                #/  .,#,                      
           #.   #*                              ,(###((####/.                   
          .#.   #*                          .,##      ###*  /#(                 
           #.   #*                          #(            /#/ *#*               
           #.   //////(/                   ((               (# ,#.              
           #.         #/                   #*               ,#. #*              
           #.         /((((#/          (#((##               (# *#.              
           #.        ..    #/          (#   (#            .#, /#.               
          .#.        .     ,***,*****,**,    .#(.           (#/##               
         ..#.                                    (#########,  (##.              
       .   (#(/////////////////*///*///****//*//*/////##/ ###/  .#(  .          
              .       ..       ..                         .      . .           
            .. .     .           .                               .  .           
                                                                                                                                                         
"

echo -e "${Magenta}[+] WELCOME to NSF(Network Scanning Framework)${NC}"
echo -e "${Magenta}[+] Developed By Rishabh Bhasin${NC}"
echo -e "${Magenta}[+] Using NMAP Tool${NC}\n\n"

Host=""

display_usage() {
    echo -e "${CYAN}Usage:${NC} ./nsf [-H <host>]"
    echo -e "${CYAN}Options:${NC}"
    echo "  -H, --host    The IP Address or Hostname for Scanning"
    echo "  -h, --help    Display this help message"
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        -H|--host)
            if [[ -n "$2" ]]; then
                Host=$2
                shift 2
            else
                echo -e "${RED}[!] Error: Host argument is missing.${NC}"
                display_usage
                exit 1
            fi
            ;;
        -h|--help)
            display_usage
            exit 0
            ;;
        *)
            echo -e "${RED}[!] Error: Unknown option: $1${NC}"
            display_usage
            exit 1
            ;;
    esac
done

if [[ -z "$Host" ]]; then
    echo -e "${YELLOW}[-] Enter The IP Address And Hostname for Scanning : ${NC}"
    read Host

    if [[ -z "$Host" ]]; then
        echo -e "${RED}[!] Error: Host cannot be empty.${NC}"
        exit 1
    fi
fi

echo -e "${BLUE}The Host Is $Host\n\n${NC}"

while true; do
    echo -e "${GREEN}[+] Select the Scanning Technique${NC}"
    echo -e "${GREEN}[1] TCP syn port scan${NC}"
    echo -e "${GREEN}[2] TCP connect port scan${NC}"
    echo -e "${GREEN}[3] UDP port scan${NC}"
    echo -e "${GREEN}[4] TCP ack port scan${NC}"
    echo
    echo -e "${YELLOW}[-] Input the number and press enter or leave empty for NONE: ${NC}"
    read st
    if [[ "$st" =~ ^[1-4]$ ]]; then
        case $st in
            1)
                st=" -sS "
                ;;
            2)
                st=" -sT "
                ;;
            3)
                st=" -sU "
                ;;
            4)
                st=" -sA "
                ;;
        esac
        echo -e "\n${BLUE}$st\n${NC}"
        break
    elif [[ -z "$st" ]]; then
        st=""
        echo -e "\n${YELLOW}No Option Selected\n${NC}"
        break
    else
        echo -e "\n\n\n${RED}[?] Oops! Wrong Input! Try again\n\n\n${NC}"
    fi
done

while true; do
    echo -e "${GREEN}[+] Select the Host Discovery${NC}"
    echo -e "${GREEN}[1] Only port scan${NC}"
    echo -e "${GREEN}[2] Only host discover${NC}"
    echo -e "${GREEN}[3] ARP discovery on a local network${NC}"
    echo -e "${GREEN}[4] Disable DNS resolution${NC}"
    echo
    echo -e "${YELLOW}[-] Input the number and press enter or leave empty for NONE: ${NC}"
    read hd

    if [[ "$hd" =~ ^[1-4]$ ]]; then
        case $hd in
            1)
                hd=" -Pn "
                ;;
            2)
                hd=" -sn "
                ;;
            3)
                hd=" -PR "
                ;;
            4)
                hd=" -n "
                ;;
        esac
        echo -e "\n${BLUE}$hd\n${NC}"
        break
    elif [[ -z "$hd" ]]; then
        hd=""
        echo -e "\n${YELLOW}No Option Selected\n${NC}"
        break
    else
        echo -e "\n\n\n${RED}[?] Oops! Wrong Input! Try again\n\n\n${NC}"
    fi
done

while true; do
    echo -e "${GREEN}[+] Select the Port Specification${NC}"
    echo -e "${GREEN}[1] Specify a port or port range${NC}"
    echo -e "${GREEN}[2] Scan all ports${NC}"
    echo -e "${GREEN}[3] fast port scan${NC}"
    echo
    echo -e "${YELLOW}[-] Input the number and press enter or leave empty for NONE: ${NC}"
    read ps

    if [[ "$ps" =~ ^[1-3]$ ]]; then
        case $ps in
            1)
                echo -e "${YELLOW}[-] Enter the Starting port : ${NC}"
                read d
                echo -e "${YELLOW}[-] Enter the End port : ${NC}"
                read r
                ps=" -p $d-$r "
                ;;
            2)
                ps=" -p- "
                ;;
            3)
                ps=" -F "
                ;;
        esac
        echo -e "\n${BLUE}$ps\n${NC}"
        break
    elif [[ -z "$ps" ]]; then
        ps=""
        echo -e "\n${YELLOW}No Option Selected\n${NC}"
        break
    else
        echo -e "\n\n\n${RED}[?] Oops! Wrong Input! Try again\n\n\n${NC}"
    fi
done

while true; do
    echo -e "${GREEN}[+] Select the Service Version and OS Detection${NC}"
    echo -e "${GREEN}[1] Detect the version of services running${NC}"
    echo -e "${GREEN}[2] Aggressive scan${NC}"
    echo -e "${GREEN}[3] Detect operating system of the target${NC}"
    echo
    echo -e "${YELLOW}[-] Input the number and press enter or leave empty for NONE: ${NC}"
    read svod

    if [[ "$svod" =~ ^[1-3]$ ]]; then
        case $svod in
            1)
                svod=" -sV "
                ;;
            2)
                svod=" -A "
                ;;
            3)
                svod=" -O "
                ;;
        esac
        echo -e "\n${BLUE}$svod\n${NC}"
        break
    elif [[ -z "$svod" ]]; then
        svod=""
        echo -e "\n${YELLOW}No Option Selected\n${NC}"
        break
    else
        echo -e "\n\n\n${RED}[?] Oops! Wrong Input! Try again\n\n\n${NC}"
    fi
done

while true; do
    echo -e "${GREEN}[+] Select the Timing and Performance${NC}"
    echo -e "${GREEN}[1] Paranoid IDS evasion${NC}"
    echo -e "${GREEN}[2] Sneaky IDS evasion${NC}"
    echo -e "${GREEN}[3] polite IDS evasion${NC}"
    echo -e "${GREEN}[4] Normal IDS evasion${NC}"
    echo -e "${GREEN}[5] Aggressive speed scan${NC}"
    echo -e "${GREEN}[6] Insane speed scan${NC}"
    echo
    echo -e "${YELLOW}[-] Input the number and press enter or leave empty for NONE: ${NC}"
    read tnp

    if [[ "$tnp" =~ ^[1-6]$ ]]; then
        case $tnp in
            1)
                tnp=" -T0 "
                ;;
            2)
                tnp=" -T1 "
                ;;
            3)
                tnp=" -T2 "
                ;;
            4)
                tnp=" -T3 "
                ;;
            5)
                tnp=" -T4 "
                ;;
            6)
                tnp=" -T5 "
                ;;
        esac
        echo -e "\n${BLUE}$tnp\n${NC}"
        break
    elif [[ -z "$tnp" ]]; then
        tnp=""
        echo -e "\n${YELLOW}No Option Selected\n${NC}"
        break
    else
        echo -e "\n\n\n${RED}[?] Oops! Wrong Input! Try again\n\n\n${NC}"
    fi
done

while true; do
    echo -e "${GREEN}[+] Select the NSE Scripts${NC}"
    echo -e "${GREEN}[1] Default script scan${NC}"
    echo -e "${GREEN}[2] Banner grabbing${NC}"
    echo
    echo -e "${YELLOW}[-] Input the number and press enter or leave empty for NONE: ${NC}"
    read nse

    if [[ "$nse" =~ ^[1-2]$ ]]; then
        case $nse in
            1)
                nse=" -sC "
                ;;
            2)
                nse=" -script banner "
                ;;
        esac
        echo -e "\n${BLUE}$nse\n${NC}"
        break
    elif [[ -z "$nse" ]]; then
        nse=""
        echo -e "\n${YELLOW}No Option Selected\n${NC}"
        break
    else
        echo -e "\n\n\n${RED}[?] Oops! Wrong Input! Try again\n\n\n${NC}"
    fi
done

while true; do
    echo -e "${GREEN}[+] Select the IDS Evasion${NC}"
    echo -e "${GREEN}[1] Use fragmented IP packets${NC}"
    echo -e "${GREEN}[2] Decoy scans${NC}"
    echo -e "${GREEN}[3] Use a given source port number${NC}"
    echo
    echo -e "${YELLOW}[-] Input the number and press enter or leave empty for NONE: ${NC}"
    read ids

    if [[ "$ids" =~ ^[1-3]$ ]]; then
        case $ids in
            1)
                ids=" -sV "
                ;;
            2)
                ids=" -A "
                ;;
            3)
                ids=" -O "
                ;;
        esac
        echo -e "\n${BLUE}$ids\n${NC}"
        break
    elif [[ -z "$ids" ]]; then
        ids=""
        echo -e "\n${YELLOW}No Option Selected\n${NC}"
        break
    else
        echo -e "\n\n\n${RED}[?] Oops! Wrong Input! Try again\n\n\n${NC}"
    fi
done

command="sudo nmap$st$hd$ps$svod$tnp$nse$ids $Host"
echo -e "${GREEN}Command : $command${NC}"
echo -e "\n\n\n"
eval "$command"
