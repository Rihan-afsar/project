while true
do
clear
sh writerc "\033[36mPayroll Processing System\033[37m" 7 27 "B"
sh writerc "\033[36mReports Menu\033[37m" 8 33 "N"
sh writerc "\033[1mM\033[0mailing Labels" 10 30 "N"
sh writerc "\033[1mL\033[0meave status Report" 11 30 "N"
sh writerc "\033[1mP\033[0maysheet Printing" 12 30 "N"
sh writerc "\033[1mS\033[0mummary Payroll sheet" 13 30 "N"
sh writerc "\033[1mR\033[0meturn to main menu" 14 30 "N"
sh writerc "Your Choice?" 16 30 "N"
choice=""
stty -icanon min 0 time 0
while [ -z "$choice" ]
do
	read choice
done
stty sane
case "$choice" in
	[Mm]) sh maillbl.sh ;;
	[Ll]) sh lsr.sh ;;
	[Pp]) sh payprint.sh ;;
	[Ss]) sh spaysheet.sh ;;
	[Rr]) clear
	break ;;
	*) echo -e "\007" ;;
esac
done
