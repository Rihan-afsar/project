clear
dept="MFG:ASSLY:STORES:MAINT:ACCTS"

t=`tty`
IFSspace="$IFS"
IFScolon=":"
month=`date +%m`
year=`date +%Y`

	sh writecentre "Payroll Processing System" 1 "B"
	sh writecentre "Summary Payroll Sheet" 2 "B"
	sh writecentre "$month $year" 3 "B"

sh writerc "Total" 5 20 "B"
sh writerc "Gross" 5 35 "B"
sh writerc "Gross" 5 50 "B"
sh writerc "Net" 5 70 "B"
sh writerc "Department" 6 5 "B"
sh writerc "Employees" 6 20 "B"
sh writerc "Earning" 6 35 "B"
sh writerc "Deduction" 6 50 "B"
sh writerc "Payments" 6 70 "B"

count=1
row=8 

	while [ $count -le 5 ]
	do
		var=`echo $dept |cut -d":" -f $count`
	tot_emp=0
	gross_earn=0
	gross_ded=0
	net_pay=0
	IFS="$IFScolon"
exec < $TRAN

while read t_empcode t_dept t_cl t_ml t_pl t_lwp t_da t_hra t_ca t_cca t_sppay_1 t_sppay_2 t_gs t_gpf t_gis t_esis t_inc_tax t_prof_tax t_rent_ded t_lt_loan t_st_loan t_spded_1 t_spded_2 t_tot_ded t_net_pay
do
	IFS="$IFSspace"
	if [ "$t_dept" = "$var" ]
	then 
		tot_emp=`expr $tot_emp + 1`
		gross_earn=`echo "scale=2; $gross_earn + $t_gs" |bc`
		gross_ded=`echo "scale = 2; $gross_ded + $t_tot_ded"|bc`
		net_pay=`echo "scale = 2; $net_pay + $t_net_pay" |bc`

	fi
	IFS="$IFScolon"
	done
exec < $t

	sh writerc "$var" $row 5 "N"
	sh writerc "$tot_emp" $row 20 "N"
	sh writerc "$gross_earn" $row 35 "N"
	sh writerc "$gross_ded" $row 50 "N"
	sh writerc "$net_pay" $row 70 "N"

IFS="$IFSspace"
	row=`expr $row + 1`
	count=`expr $count + 1`
done
IFS="$IFSspace"
sh writerc "Press any key..." 24 10 "N"
read key

