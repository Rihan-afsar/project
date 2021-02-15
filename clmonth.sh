clear
sh writecentre "Payroll Processing System" 2 "B"
sh writecentre "Close Current Month" 3 "B"
set `date`
cur_mth=$2

if [ -f "etrn$cur_mth.dbf" ]
then
	sh writecentre "Month has already been closed. Press any key..." 15 "B"
read key
exit
fi
	count=`wc -l $MASTER`
	set $count
	mcount=$1
count=`wc -l $TRAN`
set $count
tcount=$1

	if [ $mcount -gt $tcount ]
	then
	sh writecentre "Transaction file incomplete. Cannot close month." 15 "B"
	sh writecentre "Press any key..." 16 "B"
read key
exit
fi
	mv $TRAN etran$cur_mth.dbf
touch $TRAN
if [ $? -eq 0 ]
then
	sh writecentre "Month successfully closed... Press any key" 15 "B"
else
	sh writecentre "Unable to close month... Press any key" 15 "B"
fi
read key

