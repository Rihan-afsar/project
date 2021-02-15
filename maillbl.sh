clear
t=`tty`
sh writerc "Screen/Printer " 10 20 "B"
read ans
sh writerc "Please wait..." 12 22 "B"

	exec < $MASTER

while true
do
read line1 
if [ $? -eq 0 ]
then
name1=`echo $line1 |cut -d":" -f2`
add1=`echo $line1 |cut -d":" -f4`
city1=`echo $line1 |cut -d":" -f5`
pin1=`echo $line1 |cut -d":" -f6`

ln1=`echo $name1|wc -c`
la1=`echo $add1|wc -c`
lc1=`echo $city1|wc -c`
lp1=`echo $pin1|wc -c`

bn1=`expr 40 - $ln1`
ba1=`expr 40 - $la1`
bc1=`expr 40 - $lc1`
bp1=`expr 40 - $lp1`

count=1
while [ $count -le $bn1 ]
do
name1="$name1"
count=`expr $count + 1`
done
		count=1
		while [ $count -le $ba1 ]
		do
		add1="$add1"
		count=`expr $count + 1`
		done

		count=1
		while [ $count -le $bc1 ]
		do 
			city1="$city1"
			count=`expr $count + 1`
		done

count=1
while [ $count -le $bp1 ]
do
	pin1="$pin1"
	count=`expr $count + 1`
done
else
break
	fi

line2=""
read line2
	name2=`echo $line2 |cut -d":" -f2`
	add2=`echo $line2 |cut -d":" -f4`
	city2=`echo $line2 |cut -d":" -f5`
	pin2=`echo $line2 |cut -d":" -f6`

echo "$name1 $name2" >> mail.lbl
echo "$add1 $add2" >> mail.lbl
echo "$city1 $city2" >> mail.lbl
echo "$pin1 $pin2" >> mil.lbl
echo  >> mail.lbl
done

exec < $t

if [ "$ans" = S -o "$ans" = s ]
then
more mail.lbl

#else
#lpr mail.lbl

fi
rm mail.lbl

