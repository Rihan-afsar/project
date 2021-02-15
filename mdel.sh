another=y
while [ "$another" = "y" -o "$another" = "Y" ]
do
clear
sh writecentre "Payroll Processing System" 1 "B"
sh writecentre "Delete Records - Master File" 3 "B"

sh writerc "Employee Code to delete: \c" 6 10 "B"
read e_empcode
if [ -z "$e_empcode" ]
then
	exit
fi
grep -y \^$e_empcode $MASTER > /dev/null
if [ $? -ne 0 ]
then
sh writerc "Employee code does not exist... Press any key" 10 10 "B"
read key
continue
fi
grep -vy \^$e_empcode $MASTER > /tmp/emaster.ddd
mv /tmp/emaster.ddd $MASTER
grep -y \^$e_emocode $TRAN > /dev/null
if [ $? -eq 0 ]
then
	grep -vy \^$e_empcode $TRAN > /tmp/etran.ddd
	mv /tmp/emaster.ddd $TRAN
fi
sh writerc "Delete another y/n" 16 15 "B"
read another
done
