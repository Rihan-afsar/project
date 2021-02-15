while true
do
clear
sh writecentre "Payroll Processing System" 7 "B"
sh writecentre "Master File Data Entery" 8 "B"
sh writerc "\033[1mA\033[0mdd records" 10 30 "N"
sh writerc "\033[1mM\033[0modify records" 11 30 "N"
sh writerc "\033[1mD\033[0melete record" 12 30 "N"
sh writerc "\033[1mR\033[0metrieve record" 13 30 "N"
sh writerc "r\033[1mE\033[0mturn" 14 30 "N"
sh writerc "Your choice?" 16 30 "N"
choice=""
stty -icanon min 0 time 0
while [ -z "$choice" ]
do
read choice
done
stty sane
case "$choice" in 
	[Aa]) sh madd.sh ;;
	[Mm]) sh mmodi.sh ;;
	[Dd]) sh mdel.sh ;;
	[Rr]) sh mret.sh ;;
	[Ee]) exit ;;
	*)echo -e \007 ;;
esac
done

