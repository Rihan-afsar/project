another=y
while [ "$another" = "y" -o "$another" = "Y" ]
do 
clear
sh writecentre "Payroll Processing System" 1 "B"
sh writecentre "Modify Records - Master File" 2 "B"
sh writerc "Employee Code: \c" 4 10 "B"
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
grep -vi \^$e_empcode $MASTER > /tmp/emaster.mmm
mline=`grep -i \^$e_empcode: $MASTER`
oldIFS="$IFS"
IFS=":"
set -- $mline
sh writerc "Name: $2" 5 10 "N"
read e_empname
if [ -z "$e_empname" ]
then
	e_empname=$2
fi
sh writerc "Sex: $3" 6 10 "N"
read e_sex
if [ -z "$e_sex" ]
then 
	e_sex=$3
fi
sh writerc "Address: $4" 7 10 "N"
read e_address
if [ -z "$e_address" ]
 then
e_address=$4
fi
sh writerc "City: $5" 8 10 "N"
read e_city
if [ -z "$e_city" ]
then
	e_city=$5
fi
sh writerc "Pin code No.: $6" 9 10 "N"
read e_pin
if [ -z "$e_pin" ]
then
	e_pin=$6
fi
sh writerc "Department: $7" 10 10 "N"
read e_dept
if [ -z "$e_dept" ]
then
	e_dept=$7
fi
sh writerc "Grade: $8" 11 10 "N"
read e_grade
if [ -z "$e_grade" ]
then
e_grade=$8
fi
sh writerc "GPF no: $9" 12 10 "N"
read e_gpf_no
if [ -z "$e_gpf_no" ]
then
e_gpf_no=$9
fi
shift 9
sh writerc "GI scheme no:$1" 13 10 "N"
read e_gis_no
if [ -z "$e_gis_no" ]
then
e_gis_no=$1
fi
sh writerc "ESI sscheme no: $2" 14 10 "N"
read e_esis_no
if [ -z "$e_esis_no" ]
then
	e_esis_no=$2
fi
sh writerc "CL allowed: $3" 15 10 "N"
read e_max_cl
if [ -z "$e_max_cl" ]
then
	e_max_cl=$3
fi
sh writerc "PL allowed: $4" 16 10 "N"
read e_max_pl
if [ -z "$e_max_pl" ]
then
	e_max_pl=$4
fi
sh writerc "ML allowed: $5" 17 10 "N"
read e_max_ml
if [ -z "$e_max_ml" ]
then
	e_max_ml=$5
fi
sh writerc "Basic salary: $6" 18 10 "N"
read e_bs
if [ -z "$e_bs" ]
then
	e_bs=$6
fi
e_cum_cl=$7
e_cum_pl=$8
e_cum_ml=$9

shift 9
e_cum_lwp=$1
e_cum_att=$2
IFS="$oldIFS"

echo $e_empcode:$e_empname:$e_sex:$e_address:$e_city:$e_pin:$e_dept:$e_grade:$e_gpf_no:$e_gis_no:$e_esis_no:$e_max_cl:$e_max_pl:$e_max_ml:$e_bs:$e_cum_cl:$e_cum_pl:$e_cum_ml:$e_cum_lwp:$e_cum_att |dd conv=ucase 2> /dev/null >> /tmp/emaster.mmm
mv /tmp/emaster.mmm $MASTER
sh writerc "Modify Another y/n \c" 20 20 "N"
read another
done
