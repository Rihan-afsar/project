clear
another=y
t=`tty`
month=`date +%B`
IFSspace="$IFS"
while [ "$another" = "y" -o "$another" = "Y" ]
do
	clear
	sh writecentre "Payroll Processing System" 1 "B"
	sh writecentre "Leave Status Report" 2 "B"
	
sh writerc "Employee Code:" 4 10 "B"
read empcode
if [ -z "$empcode" ]
then
	exit
fi

grep \^$empcode $MASTER > /dev/null
if [ $? -ne 0 ]
then
	sh writerc "Employee code does not exist. Press any key..." 10 10 "B"
	read key
	continue
fi
IFS=":"
exec < $MASTER

while read e_empcode e_empname e_sex e_address e_city e_pin e_dept e_grade e_gpf_no e_gis_no e_esis_no e_max_cl e_max_pl e_max_ml e_bs e_cum_cl  e_cum_pl e_cum_ml e_cum_lwp e_cum_att
do
        if [ "$empcode" = "$e_empcode" ]
then
        break
fi
done

exec < $t
IFS="$IFSspace"


bal_cl=`expr $e_max_cl - $e_cum_cl`
bal_ml=`expr $e_max_ml - $e_cum_cl`
bal_pl=`expr $e_max_pl - $e_cum_pl`

sh writerc "	                       	" 4 1 "N"
sh writerc "\033[1mName:\033[0m$e_empname" 5 1 "N"
sh writerc "\033[1mEmpcode:\033[0m$e_empcode" 5 35 "N"
sh writerc "\033[1mGrade:\033[0m$e_grade" 5 55 "N"
sh writerc "\033[1mMonth:\033[0m$month" 5 66 "N"


sh writerc "CL Allowed" 7 1 "B"
sh writerc "ML Allowed" 7 15 "B"
sh writerc "PL Allowed" 7 35 "B"
sh writerc "$e_max_cl" 8 1 "N"
sh writerc "$e_max_ml" 8 15 "N"
sh writerc "$e_max_pl" 8 35 "N"

sh writerc "Cum.CI" 10 1 "B"
sh writerc "Cum.ML" 10 15 "B"
sh writerc "Cum.PL" 10 35 "B"
sh writerc "Cum.LWP" 10 55 "B"
sh writerc "Cum.Att.Days" 10 66 "B"
sh writerc "$e_cum_cl" 11 1 "N"
sh writerc "$e_cum_ml" 11 15 "N"
sh writerc "$e_cum_pl" 11 35 "N"
sh writerc "$e_cum_lwp" 11 55 "N"
sh writerc "$e_cum_att" 11 66 "N"

sh writerc "Balance CL" 13 1 "B"
sh writerc "Balance ML" 13 15 "B"
sh writerc "Balance PL" 13 35 "B"
sh writerc "$bal_cl" 14 1 "N"
sh writerc "$bal_ml" 14 15 "N"
sh writerc "$bal_pl" 14 35 "N"
	sh writerc "Another employee y/n " 21 10 "N"
	read another
done
