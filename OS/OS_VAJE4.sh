#!/bin/bash


#echo $# #(stevilo argumentov)
#echo $@ #(vsi argumenti)

#loops
#while true
#do
#	echo
#done



#until [ nek pogoj ]
#do
#	cat $file
#done



#for var in "$@"
#do
#	echo $var
#done

#echo $1
#shift    #premakne okno argumentov za 1 v desno
#echo $1  

#while [ -n "$1" ]; do
#	echo "$1"
#	shift
#done

#case "$1" in
#	(--help|-h)
#		echo "to je help"
#		;;
#	(--test)
#		echo "to je test"
#		;;
#	(*)
#		echo "to je default"
#		;;
#esac

#while [ -n "$1" ]; do 
#	case "$1" in
#		(--help|-h)
#			echo "to je help"
#			exit
#			;;
#		(--test)
#			echo "to je test"
#			exit
#			;;
#		(--number|-n)
#			number=$2
#			shift
#			shift
#			;;
#
#		(*)
#			echo "default"
#			;;
#
#	esac
#done

#var="$(cat)"
#echo "$var"

#read var  #branje po vrsticag
#echo "$var"

#while read line; do  #simuliranje cat commanda
#	echo "$line"
#done

#for (( i = 1; i < 10; i++)); do  
#	echo $i
#done

#function fun {
#	echo $1
#	echo "to je funkcija"
#}
#
#fun argument

#function fact1 {
#	local n="$1"
#	if [ $n -eq 1 ]; then
#		return $n
#	else
#		fact1 $((n - 1))
#		nn=$?
#		return $((n * nn))
#	fi 
#}
#
#fact1 6
#echo $? #narobe, ker je return status 8-biten

#function fact2 {
#	local n="$1"
#	if [ $n -eq 1 ]; then
#		echo $n
#	else
#		nn=$( fact2 $((n - 1)))
#		echo $((n * nn))
#	fi
#}
#
#echo $(fact2 6)     #deluje praviln