#!/bin/bash
echo "installing essential dev tools"

while IFS='' read -r line || [[ -n "$line" ]]; do    
 	apt-get install $line
done < "dev-tools.apt.list"

echo -n "Python and things, maybe?"
select yn in "Yes" "No"; do
	case $yn in
		Yes ) /bin/bash python.sh; break;;
		No ) 	echo -n "Not installing Python"
	esac
done

echo -n "Java Stuff, you want?"
select yn in "Yes" "No"; do
	case $yn in
		Yes ) /bin/bash java.sh; break;;
		No ) 	echo -n "Not installing Java"
	esac
done

echo -n "Ruby shit, same question"
select yn in "Yes" "No"; do
	case $yn in
		Yes ) /bin/bash ruby.sh; break;;
		No ) 	echo -n "Not installing Java"
	esac
done

echo -n "Full LAMP stack with Laravel, ICANHAZ?"
select yn in "Yes" "No"; do
	case $yn in
		Yes ) /bin/bash laravel.sh; break;;
		No ) 	echo -n "Not installing Java"
	esac
done