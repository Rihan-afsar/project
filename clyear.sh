clear

sh writecentre "Payroll Processing System" 2 "B"
sh writecentre "Close Year & Reorganize" 3 "B"

t=`tty`
oldifs="$IFS"
	sh writecentre "Please wait... trying to close year" 10 "B"
yr=`date +%y`
	if [ -f "etran$yr.dbf" ]
then
	sh writecentre "Year has already been closed. Press any key..." 12 "B"
	read key
	exit
fi

months="Apr:May:Jun:Jul:Aug:Sep:Oct:Nov:Dec:Jan:Feb:Mar"
IFS=":"
set $months
count=1
flag=0
while [ $count -le 12 ]
do
		if [ -f "etran$1.dbf" ]
		then
		cat etran$1.dbf >> etran$yr.dbf
	rm stran$1.dbf
	flag=1
fi
		count=`expr $count + 1`
		shift
done
if [ $flag = 0 ]
then 
	sh writecentre "Month has not been closed. Press any key..." 12 "B"
	sh writecentre "Close month before closing year. Press any key..." 13 "B"
read key
exit
fi

	exec < $MASTER

while read e_empcode e_empname e_sex e_address e_city e_pin e_dept e_grade e_gpf_no e_gis_no e_esis_no e_max_cl e_max_pl e_max_ml e_bs e_cum_cl e_cum_ple_cum_ml e_cum_lwp e_cum_att
do
	e_cum_cl=0
	e_cum_pl=0
	e_cum_ml=0
	e_cum_lwp=0
	e_cum_att=0

	IFS="$oldifs"


echo $e_empcode:$e_empname:$e_sex:$e_address:$e_city:$e_pin:$e_dept:$e_grade:$e_gpf_no:$e_gis_no:$e_esis_no:$e_max_cl:$e_max_pl:$e_max_ml:$e_bs:$e_cum_cl:$e_cum_pl:$e_cum_ml:$e_cum_lwp:$e_cum_att >> /tmp/master

IFS=":"
done

IFS="$oldifs"
mv /tmp/master $MASTER

exec < $t
sh writecentre "Year has been closed successfully. press any key..." 12 "B"
read key

