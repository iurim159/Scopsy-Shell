#!/bin/bash

# --- Funzioni di utilità per colori ---
print_red()    { echo -ne "\e[1;31m$1\e[0m"; }
print_green()  { echo -ne "\e[1;32m$1\e[0m"; }
print_reset()  { tput sgr0; }

# --- Controllo dipendenze ---
command -v toilet >/dev/null 2>&1 || {
    echo "Comando 'toilet' non trovato. Installa con: sudo apt install toilet"
    exit 1
}

# --- Controllo utente root ---
if [ "$EUID" -ne 0 ]; then
    echo "Devi eseguire questo programma come utente root (usa sudo)."
    exit 1
fi
# --- Titolo iniziale ---
toilet --font pagga.tlf --filter border: scopsy
echo "by Iurim159"
echo ""

# --- Ciclo principale ---
while true; do
    print_red "scopsyconsole>> "; print_reset

    # --- Scroll storico dei comandi ---
    HISTFILE=~/.scopsy_history
    history -r "$HISTFILE"
    read -e -p "" cmd arg1 arg2 arg3 arg4 arg5 arg6 arg7 arg8 arg9
    history -s "$cmd $arg1 $arg2 $arg3 $arg4 $arg5 $arg6 $arg7 $arg8 $arg9"
    history -w "$HISTFILE"

    case "$cmd" in
        # --- Comandi di sistema e file ---
        ls) ls -la ;;
        move|cd) cd "$arg1" 2>/dev/null || echo "Cartella '$arg1' non trovata." ;;
        cartella) mkdir -p "$arg1" && echo "Cartella '$arg1' creata." ;;
        cancella) clear ;;
        exit) echo "Uscita da scopsyconsole."; exit ;;

        # --- Rete ---
        ping) ping -c 4 "$arg1" ;;
        scan) sudo nmap -p- -sV -sC "$arg1" ;;
        whois) whois "$arg1" ;;
        dig) dig "$arg1" ;;

        # --- Installazione ---
        installa) sudo apt-get update && sudo apt-get install -y "$arg1" ;;

        # --- Strumenti di sicurezza ---
        hydra) sudo hydra -L "$arg3" -P "$arg3" "$arg1"://"$arg2" ;;
        john) john "$arg1" ;;
        hashcat) hashcat -a 0 -m 0 "$arg1" "$arg2" ;;
        sqlmap) sudo sqlmap -u "$arg1" ;;
        nikto) sudo nikto -h "$arg1" ;;
        wpscan) sudo wpscan --url "$arg1" ;;
        setoolkit) sudo setoolkit ;;
        msfconsole) sudo msfconsole ;;
        aircrack) echo "Per usare aircrack-ng, esegui i comandi specifici in modalità privilegiata." ;;
        maltego) maltego ;;

        # --- Aiuto ---
        !help)
            echo ""
            echo "Comandi disponibili:"
            echo "  ls                         - Lista file e cartelle"
            echo "  move|cd [cartella]         - Cambia directory"
            echo "  cartella [nome]            - Crea una nuova cartella"
            echo "  cancella                   - Pulisce lo schermo"
            echo ""
            echo "  ping [host]                - Ping verso un host"
            echo "  scan [host]                - Scansione porte TCP con Nmap"
            echo "  whois [dominio/ip]         - Informazioni WHOIS"
            echo "  dig [dominio]              - Query DNS"
            echo ""
            echo "  installa [pacchetto]       - Installa pacchetto con apt-get"
            echo ""
            echo "  hydra [proto] [host] [wl]  - Brute force con Hydra"
            echo "  john [hashfile]            - Cracking password con John"
            echo "  hashcat [hashfile] [wl]    - Cracking password con Hashcat"
            echo "  sqlmap -u [url]            - Test SQL Injection"
            echo "  nikto [url]                - Vulnerabilità web con Nikto"
            echo "  wpscan [url]               - Scansione WordPress"
            echo "  setoolkit                  - Avvia Social Engineering Toolkit"
            echo "  msfconsole                 - Avvia Metasploit Framework"
            echo "  maltego                    - Avvia Maltego (GUI)"
            echo "  aircrack                   - (usa modalità privilegiata)"
            echo ""
            echo "  exit                       - Esce da scopsyconsole"
            echo ""
            ;;

        *)
            # Prova a eseguire il comando come comando di sistema in modo sicuro
            if [[ -n "$cmd" && "$cmd" =~ ^[a-zA-Z0-9._-]+$ && $(command -v "$cmd") ]]; then
                "$cmd" $arg1 $arg2 $arg3 $arg4 $arg5 $arg6 $arg7 $arg8 $arg9 2>/dev/null
                if [ $? -ne 0 ]; then
                    echo "ERRORE: comando non riconosciuto o errore di esecuzione. Digita '!help' per la lista dei comandi."
                fi
            else
                echo "ERRORE: comando non valido. Digita '!help' per la lista dei comandi."
            fi
            ;;
    esac
done