#paymain
#Does some ninitial house-keeping, Dispalys Main Menu
#and branches control to appropriate sub-menu.


MASTER=$HOME/Project/emaster.dbf
TRAN=$HOME/Project/etran.dbf
export MASTER TRAN

#check if master and transaction files exist
if [ ! -f $MASTER ]
then
	touch $MASTER
fi
if [ ! -f $TRAN ]
then
	touch $TRAN
fi
while true
do
	#display main Menu
	clear
	sh writecentre "Payroll Processing System" 7 "B"
	sh writecentre "Main Menu" 8 "N"
	sh writerc "\033[1mD\033[0matabase oprations" 10 30 "N"
	sh writerc "\033[1mR\033[0meports" 11 30 "N"
	sh writerc "\033[1mS\033[0mystem maintenance" 12 30 "N"
	sh writerc "\033[1mE\033[0mxit" 13 30 "N"
	sh writerc "Your choice?" 15 30 "N"
#recevie user's choice
choice=""
	stty -icanon min 0 time 0
	while [ -z "$choice"]
	do
		read choice
	done
	stty sane
#branch off to appropriate menu
case "$choice" in
	[Dd]) sh dboper.sh ;;
	[Rr]) sh reports.sh ;;
	[Ss]) sh sysmnt.sh ;;
	[Ee]) clear
		exit ;;
	*) echo -e \007 ;;
esac
done

