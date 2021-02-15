while true
do
clear
sh writerc "\033[36mPayroll Processing System\033[37m" 7 27 "B"
sh writerc "\033[32mSyestem Maintenance Menu\033[37m" 8 28 "B"
sh writerc "c\033[1mL\033[0mose month" 10 30 "N"
sh writerc "\033[1mC\033[0mlose year & reorganise" 11 30 "N"
sh writerc "\033[1mR\033[0meturn to main menu" 12 30 "N"
sh writerc "Your choice?" 14 30 "N"
choice=""
stty -icanon min 0 time 0
while [ -z "$choice" ]
do
	read choice
	done
	stty sane
case "$choice" in
	[Ll]) sh clmonth.sh ;;
	[Cc]) sh clyear.sh ;;
	[Rr]) clear
	break ;;
 	*) echo \007 ;;
esac
done
