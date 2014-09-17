#!/bin/sh

#
# TODO: Sonderzeichen maskieren
#	Parameter verbessern	
#	Layout beim Schreiben der Tätigkeiten berücksichtigen
#	Liste beim Schreiben sortieren (wegen -t)
#

file_name="bericht.md"
file_path="~"

task_date=$(date +"%Y-%m-%d-%H-%M")

file_template () { 

# Layout kann hier angepasst werden.
#=============================================================
cat << END > $file_name
# Praktikumsbericht
## von $username


    **Datum**     |    **Tätigkeit**
__________________|_____________________
                  |
$task_date  |  $task_name 
                  |
                  |
                  |
                  |
                  |
                  |
END
#=============================================================
}

# Parameter checken
if [ -n "$1" ]
then
case $1 in
    -h)
	# Hilfe einblenden
        echo "-h   Hilfe"
	echo "-p   Bericht anzeigen"
        echo "-t   Zeit anpassen"
	exit 1
	;;
    -p)
        # Bericht ausgeben
        cat $file_path"/"$file_name
        exit 1
        ;;
    -t)
	# Zeit anpassen(WIP)
	if [[ $2 =~ ^-?[0-9]+$ ]] && [[ $3 =~ ^-?[0-9]+$ ]] 
	then
		task_date=$(date +"%Y-%m-%d-$2-$3")
        	read -p "Tätigkeit> " task_name
	else
		echo "Ungültige Eingabe. Format: -t HH MM"
		exit 1
	fi
	;;
    *)
        # Alle Parameter als Tätigkeit speichern
        task_name="$@"
esac
else
        # Keine Parameter. Eingabe abfragen.
        read -p "Tätigkeit> " task_name
fi

if [ -n "$task_name" ]
then
	if [ -f $file_path"/"$file_name ]
	then
		# Datei existiert. In Zeile schreiben.
		sed -i "8i$task_date  |  $task_name" $file_path"/"$file_name
	else
		# Datei existiert nicht. Neuen Bericht anlegen.
		read -p "Name> " username
		file_template
                echo "Neuer Bericht angelegt:" $file_path"/"$file_name
	fi
		echo "Neuer Eintrag hinzugefügt" $task_name
else
	# Keine Eingabe
	echo "Bitte Tätigkeit eingeben."
fi


