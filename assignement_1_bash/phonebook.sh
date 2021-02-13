#!bin/bash/
file=./phonebook.sh
index=0
if [ -z $1 ]
then
	echo ">> -i to insert new phone contact"
	echo ">> -v to view all contacts"
	echo ">> -s to search for phone contact"
	echo ">> -e to delete all phone contacts"
	echo ">> -d to delete one contact"
fi
###############         insert  a contact         ########################## 
if [[ $1 == "-i" ]];then
        echo "Create a new phone contact"
	read -p "Enter Name: " Name
        found=$(grep -E "(^>>>$Name":")" $file)
        echo $found
	if  [ -z "$found" ];then
            read -p "Enter phone number: " pNumber
            if [[ $pNumber =~ ^[0-9]+$ ]];then
                echo ">>>$Name:$pNumber" >> $file
            else
                echo "wrong num"
            fi
        else
            echo "do you want to add another number in this contact ? [y/n]"
	    read  yn
	    if [ $yn == "y" -o $yn == "Y" ];then
                   read -p "Enter another phone number: " pNumber
                   if [[ $pNumber =~ ^[0-9]+$ ]];then
                        sed -i "/$found/d" $file 
                        echo "$found---$pNumber">> $file
                   else
                        echo "wrong num"
                   fi
            fi
        fi
##############            search for a contact       ##########################
elif [[ $1 == "-s" ]];then
	echo "Search for a contact "
	read -p "Name  or phone number : " search
        found=$(grep -E "(^>>>$search":")" $file)
	#found=$((grep -E "($search":")" $file)|(cut -d ":" -f 1))
        if  [ -z "$found" ];then
 	      echo "No Item found"
        else
              echo $found
	fi
################            display  all contacts     ##########################  
elif [[ $1 == "-v" ]];then
        echo "Viewing all contacts list"
	cat $file | grep -E "^>>>"
################            delete all  contacts      ##########################
elif [[ $1 == "-e" ]];then
	echo "Delete all contacts"
       # > $file
        sed -i  "/^>>>/d" $file 
###############             delete  a contact        ########################## 
elif [[ $1 == "-d" ]];then
	echo "Search for a contact"
	read -p "Enter Name of the record you want to  delete : " search
	found=$(grep -E "(^>>>$search":")" $file)
	if  [ -z "$found" ] ;then
	echo "No Item found"
	else
        sed -i "/$found/d" $file
        sed -i '/^[[:space:]]*$/d' $file
	fi
###############               wrong option           #########################  
else 
     echo "wrong option"
fi
exit 0
###############         Phonebook_DataBase           #########################
>>>Nihal:01095432765---0124329876
>>>Roanne:01287654700
>>>Mohamed:0117654385
>>>khaled:012654387
