#!/bin/bash
OIFS="$IFS"
IFS=$'\n'
submissionFolder=/home/min/a/mitra26/Desktop/ECEDataScience-grader/Spring2020/homework1-grading/homework-1
gradefile=hw1_grade.csv
latedayfile=late_hw1.csv
RESULT=result/
#search string to get the name of the person
searchstring="-"
sday=24
touch $gradefile
echo "" > $gradefile
touch $latedayfile
echo "" > $latedayfile
rm -rf $RESULT/*
#first we will get list of all the files
for filelist in "${submissionFolder}"/*
	do
		#we will extract the name from the file-list
	   	name1=${filelist:101} #adjust this as per your folder location
		rm -rf problem1.py
		rm -rf problem2.py
		rm -rf st1
		rm -rf st2
		rm -rf st3
		rm -rf st4
		rm -rf st5

		echo "Testing file "${name1}
		cd $filelist
		#To check for the date of submission tag
		#git rev-parse submission| xargs git show -s --pretty=%aI| egrep ^2019> name
		#To check for last commit date
		git log -1 --format="%at" | xargs -I{} date -d @{} +%Y/%m/%d_%H:%M:%S> name
		#prints 2018/07/18 07:40:52
	        date=$(cat name)
		#month=${date::2}
	        #day=${date:3}
		day=${date:8:2}
		#echo ${dat}

		latedays=$(expr $day - $sday)
		rm -rf name
		cd ..
		cd ..
	        printf '%s\n' $name1 $latedays| paste -sd ',' >> $latedayfile

		#ro=${file-list}
		fl=0
		for file in `find ${filelist} -type f -name "problem1.py"`
			do
				cp ${file} .
				echo "hi"
				fl=1
			done
		for file in `find ${filelist} -type f -name "problem2.py"`
			do
				cp ${file} .
				echo "hi again"
				fl=1
			done


		grade=0

		rm -f error.txt
		rm -f stutest.txt

		echo "Test case 1: (50 points)" >> $RESULT/${name1}.txt
		python3 problem1.py> stutest.txt  2>error.txt
		diff <( tr -d ' \n' < stutest.txt |tr '[:upper:]' '[:lower:]') <( tr -d ' \n' <pb1) >>$RESULT/${name1}.txt
		if [ $? = "0" ]; then
			echo "Test Passed" >> $RESULT/${name1}.txt
			let "grade+=50"
		elif grep -q "124" error.txt;
		then
			echo "Test Case "${1} "Timed out" >> $RESULT/${name1}.txt
		else
			cat error.txt >> $RESULT/${name1}.txt
			echo "Test failed: 1" >> $RESULT/${name1}.txt
		fi


		rm -f stutest.txt
		echo "Test case 2: (50 points)" >> $RESULT/${name1}.txt
		python3 problem2.py> stutest.txt  2>error.txt
		tail -1 stutest.txt>st5
		tail -5 stutest.txt| head -3 > st4
		tail -9 stutest.txt| head -3 > st3
		tail -13 stutest.txt| head -3 > st2
		tail -15 stutest.txt| head -1 > st1
		echo "Part 1">> $RESULT/${name1}.txt

		diff <( tr -d ' \n' <st1 ) <( tr -d ' \n' <one) >>$RESULT/${name1}.txt>>$RESULT/${name1}.txt
		if [ $? = "0" ]; then
			echo "Test Passed" >> $RESULT/${name1}.txt
			let "grade+=10"
		elif grep -q "124" error.txt;
		then
			echo "Test Case "${2} "Timed out" >> $RESULT/${name1}.txt
		else
			cat error.txt >> $RESULT/${name1}.txt
			echo "Test failed: 2 Part 1" >> $RESULT/${name1}.txt
		fi
		echo "Part 2">> $RESULT/${name1}.txt
		diff <( tr -d ' \n' <st2 ) <( tr -d ' \n' <two) >>$RESULT/${name1}.txt>>$RESULT/${name1}.txt
		if [ $? = "0" ]; then
			echo "Test Passed" >> $RESULT/${name1}.txt
			let "grade+=10"
		elif grep -q "124" error.txt;
		then
			echo "Test Case "${2} "Timed out" >> $RESULT/${name1}.txt
		else
			cat error.txt >> $RESULT/${name1}.txt
			echo "Test failed: 2 Part 2" >> $RESULT/${name1}.txt
		fi
		echo "Part 3">> $RESULT/${name1}.txt
		diff <( tr -d ' \n' <st3 ) <( tr -d ' \n' <three) >>$RESULT/${name1}.txt>>$RESULT/${name1}.txt
		if [ $? = "0" ]; then
			echo "Test Passed" >> $RESULT/${name1}.txt
			let "grade+=10"
		elif grep -q "124" error.txt;
		then
			echo "Test Case "${2} "Timed out" >> $RESULT/${name1}.txt
		else
			cat error.txt >> $RESULT/${name1}.txt
			echo "Test failed: 2 Part 3" >> $RESULT/${name1}.txt
		fi
		echo "Part 4">> $RESULT/${name1}.txt
		diff <( tr -d ' \n' <st4 ) <( tr -d ' \n' <four) >>$RESULT/${name1}.txt>>$RESULT/${name1}.txt
		if [ $? = "0" ]; then
			echo "Test Passed" >> $RESULT/${name1}.txt
			let "grade+=10"
		elif grep -q "124" error.txt;
		then
			echo "Test Case "${2} "Timed out" >> $RESULT/${name1}.txt
		else
			cat error.txt >> $RESULT/${name1}.txt
			echo "Test failed: 2 Part 4" >> $RESULT/${name1}.txt
		fi
		echo "Part 4">> $RESULT/${name1}.txt
		diff <( tr -d ' \n' <st5 ) <( tr -d ' \n' <five) >>$RESULT/${name1}.txt>>$RESULT/${name1}.txt
		if [ $? = "0" ]; then
			echo "Test Passed" >> $RESULT/${name1}.txt
			let "grade+=10"
		elif grep -q "124" error.txt;
		then
			echo "Test Case "${2} "Timed out" >> $RESULT/${name1}.txt
		else
			cat error.txt >> $RESULT/${name1}.txt
			echo "Test failed: 2 Part 5" >> $RESULT/${name1}.txt
		fi
		rm -f stutest.txt
		cp $RESULT/${name1}.txt $filelist
		#echo "Grade is = "${grade} >> $RESULT/${name1}.txt
		printf '%s\n' $name1 $grade | paste -sd ',' >> $gradefile





	done
IFS="$OIFS"
