another=y
while [ "$another" = "y" -o "$another" = "Y" ]
do
clear
sh writecentre "Payroll maintenance System" 1 "B"
sh writecentre "Retrieve Record - Mater File" 2 "B"

sh writerc "Empoyee Code:\c" 4 10 "B"
read e_empcode
if [ -z "$e_empcode" ]
then
	exit
fi


grep -i \^$e_empcode $MASTER > /dev/null

if [ $? -ne 0 ]
then
sh writerc "Employee code does not exist. Press any key..." 10 10 "B"
read key
continue 
fi
mline=`grep -i \^$e_empcode $MASTER`
oldIFS="$IFS"
IFS=":"
set -- $mline
	sh writerc "Name:$2" 5 10 "N"
	sh writerc "Sex:$3" 6 10 "N"
	sh writerc "Address:$4" 7 10 "N"
	sh writerc "City:$5" 8 10 "N"
	sh writerc "Pin code No.:$6" 9 10 "N"
	sh writerc "Department:$7" 10 10 "N"
	sh writerc "Grade:$8" 11 10 "N"	
	sh writerc "GPF no:$9" 12 10 "N"
	shift 9	
	sh writerc "GI scheme no:$1" 13 10 "N"
	sh writerc "ESI sscheme no :$2" 14 10 "N"
	sh writerc "CL allowed:$3" 15 10 "N"
	sh writerc "PL allowed:$4" 16 10 "N"
	sh writerc "ML allowed:$5" 17 10 "N"
	sh writerc "Basic salary:$6" 18 10 "N"
	
IFS="$oldIFS"
	sh writerc "Retrieve another y/n" 20 20 "N"
	read another
done
  
