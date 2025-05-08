#!/bin/bash

toilet --font pagga.tlf --filter border:  scopsy
echo "by Iurim158"
echo ""

while  [ 1 -eq 1 ]
do
	echo -n -e '\E[1;31m'"scopsyconsole>> ";tput sgr0
	read utente w1 w2 w3 w4 w5 w6 w7 w8 w9;
	if [ $utente == "!prev" ]; then
                while [ 1 -eq 1 ]
                do
                        echo -n -e '\E[1;32m'"prevconsole>> ";tput sgr0
                        read prev;
                        $prev
                done
        fi
	case $utente in
		"ls")    ls;;
		"exit")  exit;;
		"cartella")   mkdir new folder;;
		"ping")   ping $w1;; 
		"installa")   su -s apt-get $w1;;
		"cancella")   clear;;
		"scan")   sudo nmap -p- $w1;;
		"move")   cd $w1;;
		"!help")  echo "questa è una lista di tutto quello che puoi fare:"
                        echo "ls == per guardare tutto ciò che è presente nella cartella"
                        echo "cd [cartella]== per spostardsi da una cartella all'altra"
                        echo "ping [ip] == per pingare un sito"
                        echo "scan [ip] == scannerizza un ip"
                        echo "installa [nome] == per installare tool esterni"
                        echo "exit == per uscire dal programma"
                        echo ""
                        echo "se vuoi eseguire comandi non presenti in Scopsy entra in modalità previligiata"
                        echo "!prev == utente previligiato";;
		*)      echo "ERRORE parametro non previsto, esegui \"!help\" per vedere i comandi che si possono svolgere";;
	esac
done
