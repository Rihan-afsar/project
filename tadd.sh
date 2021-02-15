#set -vx
clear
another=y
t=`tty`
IFScolon=":"
IFSspace="$IFS"

SSK="200 30 10 10 10 75 115 20"
HSK="200 25 10 10 10 75 115 20"
SKI="100 25 10 10 10 75 115 15"
SMS="100 22 10 10 10 75 115 15"
USK="17 20 10 10 10 750 115 0"

while [ "$another" = "y" -o "$another" = "Y" ]
do
clear 
	sh writecentre "Payroll Processing System" 1 "B"
	sh writecentre "Add Records - Tran. File" 2 "B"
	sh writerc "Employee Code:" 4 10 "B"
	read t_empcode
	if [ -z "$t_empcode" ]
then
	exit
fi
mline=`grep -i \^$t_empcode $MASTER`
mfound=$?

if [ $mfound -ne 0 ]
then
	sh writecentre "Correspondind Master record absent" 7 "N"
	sh writecentre "Press any key... " 8 "N"
	read key
continue 
fi

grep -i \^$t_empcode $TRAN > /dev/null
tfound=$? 

if [ $tfound -eq 0 ]
then
	sh writecentre "Already exists, Cannot duplicate" 7 "N"
	sh writecentre "Press any key..." 8 "N"
	read key
continue
fi

sh writerc "Department:" 5 10 "B"
read t_dept
sh writerc "Casual leave:" 6 10 "B"
read t_cl
sh writerc "Medical leave:" 7 10 "B"
read t_ml 
sh writerc "Provisional leave:" 8 10 "B"
read t_pl
sh writerc "LWP: " 9 10 "B"
read t_lwp
sh writerc "Special pay 1 : " 10 10 "B"
read t_sppay_1

sh writerc "Special pay 2 : " 11 10 "B"
read t_sppay_2
sh writerc "Income tax: " 12 10 "B"
read t_inc_tax
sh writerc "Rent deduction: " 13 10 "B"
read t_rent_ded
sh writerc "Long term loan: " 14 10 "B"
read t_lt_loan
sh writerc "Short term loan: " 15 10 "B"
read t_st_loan
sh writerc "Special ded, 1:" 16 10 "B"
read t_spded_1
sh writerc "Special ded, 2:" 17 10 "B"
read t_spded_2
grade=`echo $mline |cut -d":" -f 8`
bs=`echo $mline |cut -d":" -f 15`
set -- `eval echo \\$$grade`
t_da=`echo "scale=2;  $1 / 100.0 * $bs" |bc`
t_hra=`echo "scale=2; $2 / 100.0 * $bs" |bc`
t_ca=`echo "scale=2;  $3 / 100.0 * $bs" |bc`
t_cca=`echo "scale=2;  $4 / 100.0 * $bs" |bc`
t_gs=`echo "scale=2; $bs + $t_da + $t_hra + $t_ca + $t_cca + $t_sppay_1 + $t_sppay_2"|bc`

t_gpf=`echo "scale=2; $5 / 100.0 * ($bs + $t_da)"|bc`
t_esis=$6
t_gis=$7
t_prof_tax=$8
t_tot_ded=`echo "scale=2; $t_gpf + $t_esis + $t_gis + $t_prof_tax + $t_inc_tax + $t_lt_loan + $t_st_loan + $t_rent_ded + $t_spded_1 + $t_spded_2" |bc`

t_net_pay=`echo "scale=2;  $t_gs - $t_tot_ded" |bc`

echo $t_empcode:$t_dept:$t_cl:$t_ml:$t_pl:$t_lwp:$t_da:$t_hra:$t_ca:$t_cca:$t_sppay_1:$t_sppay_2:$t_gs:$t_gpf:$t_gis:$t_esis:$t_inc_tax:$t_prof_tax:$t_rent_ded:$t_lt_loan:$t_st_loan:$t_spded_1:$t_spded_2:$t_tot_ded:$t_net_pay | dd conv=ucase 2> /dev/null >> $TRAN

days="31 28 31 30 31 30 31 31 30 31 30 31"
months=`date +%m`
totdays=`echo $days | cut -d" " -f $months`
IFS="$IFScolon"
exec < $MASTER

while read e_empcode e_empname e_sex e_address e_city e_pin e_dept e_grade e_gpf_no e_gis_no e_esis_no e_max_cl e_max_pl e_max_ml e_bs e_cum_cl e_cum_pl e_cum_ml e_cum_lwp e_cum_att
do
	IFS="$IFSspace"
if [ "$e_empcode" = "$t_empcode" ]
then
	e_cum_cl=`expr $e_cum_cl + $t_cl`
	e_cum_ml=`expr $e_cum_ml + $t_ml`
	e_cum_pl=`expr $e_cum_pl + $t_pl`
	e_cum_lwp=`expr $e_cum_lwp + $t_lwp`
	net_days=`expr $totdays - $t_cl - $t_ml - $t_pl - $t_lwp`
	e_cum_att=`expr $e_cum_att + $net_days`
fi
	echo $e_empcode:$e_empname:$e_sex:$e_address:$e_city:$e_pin:$e_dept:$e_grade:$e_gpf_no:$e_gis_no:$e_esis_no:$e_max_cl:$e_max_pl:$e_max_ml:$e_bs:$e_cum_cl:$e_cum_pl:$e_cum_ml:$e_cum_lwp:$e_cum_att |dd conv=ucase 2> /dev/null >> /tmp/master.aaa
	
	IFS="$IFScolon"
done
mv /tmp/master.aaa $MASTER
exec < $t
	IFS="$IFSspace"
sh writerc "Add another y/n" 23 10 "N"
read another
done
