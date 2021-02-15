clear
sh writerc "Screen /Printer" 10 20 "B"
read ans
month=`date +%B`
days="31 29 31 30 31 30 31 31 30 31 30 31"
tmp=`date +%m`
mdays=`echo $days | cut -d" " -f$tmp`

another=y
t=`tty`
IFSspace="$IFS"
while [ "$another" = "y" -o "$another" = "Y" ]
do
	clear
	sh writerc "Employee Code:" 4 10 "B"
	read empcode
		if [ -z "$empcode" ]
	then
	exit
	fi

	grep \^$empcode: $MASTER > /dev/null
if [ $? -ne 0 ]
then
	sh writerc "Employee code does not exist. Press any key..." 10 10 "B"
	read key
	clear
continue
fi
	dln="-"
	count=0
while [ $count -lt 78 ]
do
	dln="$dln-"
	count=`expr $count + 1`
done

clear
sh writerc "$dln" 0 1 "B"
sh writecentre "Shivley & Brett Pvt. Ltd." 1 "B"
sh writerc "$dln" 2  1 "B"
exec < $MASTER
IFS=":"
while read e_empcode e_empname e_sex e_address e_city e_pin e_dept e_grade e_gpf_no e_gis_no e_esis_no e_max_cl e_max_pl e_max_ml e_bs e_cum_cl e_cum_pl e_cum_ml e_cum_lwp e_cum_att
do
	if [ "$empcode" = "$e_empcode" ]
then
	break
fi
done
exec < $TRAN

while read t_empcode t_dept t_cl t_ml t_pl t_lwp t_da t_hra t_ca t_cca t_sppay_1 t_sppay_2 t_gs t_gpf t_gis t_esis t_inc_tax t_prof_tax t_rent_ded t_lt_loan t_st_loan t_spded_1 t_spded_2 t_tot_ded t_net_pay
do
	if [ "$empcode" = "$t_empcode" ]
then
break
fi
done

exec < $t
IFS="$IFSspace"

sh writerc "Employee code:" 3 1  "B"
sh writerc "$e_empcode:" 3 15 "N"
sh writerc "\033[1mSex:\033[0m$e_sex" 3 24 "N"
sh writerc "\033[1mGrade:\033[0m$e_grade" 3 40 "N"
sh writerc "\033[1mMonth:\033[0m$month" 3 66 "N"
sh writerc "\033[1mName:\033[0m$e_empname" 5 1 "N"
sh writerc "\033[1mDepartment:\033[0m$e_dept" 5 50 "N"
sh writerc "\033[1mGPF NO.:\033[0m$e_gpf_no" 7 1 "N"
sh writerc "\033[1mGIS NO.:\033[0m$e_gis_no" 7 25 "N"
sh writerc "\033[1mESIS NO.:\033[0m$e_esis_no" 7 48 "N"
sh writerc "Normal Days" 9 1 "B"
sh writerc "Casu.Leav" 9 21 "B"
sh writerc "Medical Leave" 9 32 "B"
sh writerc "Prov. Leave" 9 48 "B"
sh writerc "LWP" 9 61 "B"
sh writerc "Attended Days" 9 66 "B"
sh writerc "$mdays" 10 1 "N"
sh writerc "$t_cl" 10 21 "N"
sh writerc "$t_ml" 10 32 "N"
sh writerc "$t_pl" 10 48 "N"
sh writerc "$t_lwp" 10 61 "N"
sh writerc "$e_cum_att" 10 66 "N"
sh writerc "BS" 12 1 "B"
sh writerc "DA" 12 10 "B"
sh writerc "HRA" 12 20 "B"
sh writerc "CA" 12 32 "B"
sh writerc "CCA" 12 39 "B"
sh writerc "S.P.1" 12 48 "B"
sh writerc "S.P.2" 12 54 "B"
sh writerc "GS" 12 61 "B"
sh writerc "$e_bs" 13 1 "N"
sh writerc "$t_da" 13 10 "N"
sh writerc "$t_hra" 13 20 "N"
sh writerc "$t_ca" 13 30 "N"
sh writerc "$t_cca" 13 39 "N"
sh writerc "$t_sppay_1" 13 48 "N"
sh writerc "$t_sppay_2" 13 54 "N"
sh writerc "$t_gs" 13 61 "N"
sh writerc "GPF" 15 1 "B"
sh writerc "ESIS" 15 10 "B"
sh writerc "GIS" 15 18 "B"
sh writerc "IT" 15 25 "B"
sh writerc "PT" 15 32 "B"
sh writerc "RENT" 15 39 "B"
sh writerc "Loan1" 15 48 "B"
sh writerc "Loan2" 15 54 "B"
sh writerc "S.D.1" 15 61 "B"
sh writerc "S.D.2" 15 68 "B"
sh writerc "Total" 15 74 "B"
sh writerc "$t_gpf" 16 1 "N"
sh writerc "$t_esis" 16 10 "N"
sh writerc "$t_gis" 16 18 "N"
sh writerc "$t_inc_tax" 16 25 "N"
sh writerc "$t_prof_tax" 16 32 "N"
sh writerc "$t_rent_ded" 16 39 "N"
sh writerc "$t_lt_loan" 16 48 "N"
sh writerc "$t_st_loan" 16 54 "N"
sh writerc "$t_spded_1" 16 61 "N"
sh writerc "$t_spded_2" 16 68 "N"
sh writerc "$t_tot_ded" 16 73 "N"

sh writerc "Net Pay" 18 1 "B"
sh writerc "Rs.$t_net_pay" 19 1 "N"
sh writerc "Receiver's Signature" 19 59 "B"
sh writerc "$dln" 20 1 "B"

sh writerc "Want to display another payslip y/n " 22 10 "N"
read another
done
