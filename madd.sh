
another=y
t=`tty`
while [ "$another" = "y" -o "$another" = "Y" ]
do
	clear 
sh writecentre "Payroll Processing System" 1 "B"
sh writecentre "Add Records - Master File" 2 "B"

sh writerc "Empolyee Code: \c" 4 10 "B"
read e_empcode
if [ -z "$e_empcode" ]
then
	exit
fi
#check if such an employee code already existe

grep "\^$e_empcode" $MASTER > /dev/null
if [ $? -eq 0 ]
then
	sh writerc "Code already exists. Press any key..." 20 10 "N"
	read key
	continue
fi
sh writerc "Name of Empolyee: \c" 5 10 "B"
#tput cup 5 30
read e_empname
sh writerc "Sex: \c" 6 10 "B"
#tput cup 6 30
read e_sex
sh writerc "Address: \c" 7 10 "B"
#tput cup 7 30
read e_address
sh writerc "Name of City: \c" 8 10 "B"
#tput cup 8 30
read e_city
sh writerc "Pin code number: \c" 9 10 "B"
#tput cup 9 30
read e_pin
sh writerc "Department: \c" 10 10 "B"
#tput cup 10 30
read e_dept
sh writerc "Grade: \c" 11 10 "B" 
#tput cup 11 30
read e_grade
sh writerc "GPF no.: \c" 12 10 "B"
#tput cup 12 30
read e_gpf_no
sh writerc "GI scheme no.: \c" 13 10 "B"
#tput cup 12 30
read e_gis_no
sh writerc "ESI scheme no.: \c" 14 10 "B"
read e_esis_no
sh writerc "CL allowed: \c" 15 10 "B"
read e_max_cl
sh writerc "PL allowed: \c" 16 10 "B"
read e_max_pl
sh writerc "ML allowed: \c" 17 10 "B"
read e_max_ml
sh writerc "Basic salary: \c" 18 10 "B"
read e_bs

e_cum_cl=0
e_cum_pl=0
e_cum_ml=0
e_cum_lwp=0
e_cum_att=0
echo $e_empcode:$e_empname:$e_sex:$e_address:$e_city:$e_pin:$e_dept:$e_grade:$e_gpf_no:$e_gis_no:$e_esis_no:$e_max_cl:$e_max_pl:$e_max_ml:$e_bs:$e_cum_cl:$e_cum_pl:$e_cum_ml:$e_cum_lwp:$e_cum_att| dd conv=ucase 2> /dev/null >> $MASTER

sh writerc "Add another y/n: \c" 20 10 "N"
read another
done
